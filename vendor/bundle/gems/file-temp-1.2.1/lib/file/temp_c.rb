require 'ffi'
require 'tmpdir'

class File::Temp < File
  extend FFI::Library
  ffi_lib FFI::Library::LIBC

  # :stopdoc:

  private

  if File::ALT_SEPARATOR
    attach_function :_close, [:int], :int
    attach_function :fclose, [:pointer], :int
    attach_function :_fdopen, [:int, :string], :pointer
    attach_function :_fileno, [:pointer], :int
    attach_function :_get_errno, [:pointer], :int
    attach_function :_open, [:string, :int, :int], :int
    attach_function :_open_osfhandle, [:long, :int], :int
    attach_function :tmpnam_s, [:pointer, :size_t], :int
    attach_function :mktemp_s, :_mktemp_s, [:pointer, :size_t], :int

    private_class_method :_close, :_fdopen, :_get_errno, :_open
    private_class_method :_open_osfhandle, :mktemp_s, :tmpnam_s

    ffi_lib :kernel32

    attach_function :CloseHandle, [:long], :bool
    attach_function :CreateFileW, [:buffer_in, :ulong, :ulong, :pointer, :ulong, :ulong, :ulong], :long
    attach_function :DeleteFileW, [:string], :bool
    attach_function :GetTempPathW, [:ulong, :buffer_out], :ulong
    attach_function :GetTempFileNameW, [:buffer_in, :string, :uint, :buffer_out], :uint

    private_class_method :_close, :_fdopen, :_open, :_open_osfhandle
    private_class_method :CloseHandle, :CreateFileW, :DeleteFileW
    private_class_method :GetTempPathW, :GetTempFileNameW

    S_IWRITE      = 128
    S_IREAD       = 256
    BINARY        = 0x8000
    SHORT_LIVED   = 0x1000
    GENERIC_READ  = 0x80000000
    GENERIC_WRITE = 0x40000000
    CREATE_ALWAYS = 2

    FORMAT_MESSAGE_FROM_SYSTEM    = 0x00001000
    FORMAT_MESSAGE_ARGUMENT_ARRAY = 0x00002000

    FILE_ATTRIBUTE_NORMAL     = 0x00000080
    FILE_FLAG_DELETE_ON_CLOSE = 0x04000000
    INVALID_HANDLE_VALUE      = -1
  else
    attach_function :fclose, [:pointer], :int
    attach_function :_fileno, :fileno, [:pointer], :int
    attach_function :strerror, [:int], :string
    attach_function :tmpfile, [], :pointer
    attach_function :tmpnam, [:pointer], :string
    attach_function :mktemp, [:pointer], :string

    private_class_method :mktemp, :strerror, :tmpfile, :tmpnam
  end

  private_class_method :fclose, :_fileno

  public

  # :startdoc:

  # The version of the file-temp library.
  VERSION = '1.2.1'

  # The temporary directory used on MS Windows or Unix.
  if File::ALT_SEPARATOR
    TMPDIR = ENV['TEMP'] || ENV['TMP'] || ENV['USERPROFILE'] || Dir.tmpdir
  else
    TMPDIR = ENV['TEMP'] || ENV['TMP'] || ENV['TMPDIR'] || Dir.tmpdir
  end

  # The name of the temporary file. Set to nil if the +delete+ option to the
  # constructor is true.
  attr_reader :path

  # Creates a new, anonymous, temporary file in your File::Temp::TMPDIR
  # directory
  #
  # If the +delete+ option is set to true (the default) then the temporary file
  # will be deleted automatically as soon as all references to it are closed.
  # Otherwise, the file will live on in your File::Temp::TMPDIR path.
  #
  # If the +delete+ option is set to false, then the file is not deleted. In
  # addition, you can supply a string +template+ that the system replaces with
  # a unique filename. This template should end with 3 to 6 'X' characters.
  # The default template is 'rb_file_temp_XXXXXX'. In this case the temporary
  # file lives in the directory where it was created.
  #
  # The +template+ argument is ignored if the +delete+ argument is true.
  #
  # Example:
  #
  #    fh = File::Temp.new(true, 'rb_file_temp_XXXXXX') => file
  #    fh.puts 'hello world'
  #    fh.close
  #
  def initialize(delete = true, template = 'rb_file_temp_XXXXXX')
    @fptr = nil

    if delete
      @fptr = tmpfile()
      fd = _fileno(@fptr)
    else
      begin
        omask = File.umask(077)

        ptr = FFI::MemoryPointer.from_string(template)

        if File::ALT_SEPARATOR
          errno = mktemp_s(ptr, ptr.size)

          raise SystemCallError.new('mktemp_s', errno) if errno != 0
        else
          str = mktemp(ptr)

          if str.nil? || str.empty?
            raise SystemCallError.new('mktemp', FFI.errno)
          end
        end

        @path = File.join(TMPDIR, ptr.read_string)
        @path.tr!(File::SEPARATOR, File::ALT_SEPARATOR) if File::ALT_SEPARATOR
      ensure
        File.umask(omask)
      end
    end

    if delete
      super(fd, 'wb+')
    else
      super(@path, 'wb+')
    end
  end

  # The close method was overridden to ensure the internal file pointer we
  # created in the constructor is closed. It is otherwise identical to the
  # File#close method.
  #
  def close
    super
    fclose(@fptr) if @fptr
  end

  # Generates a unique file name.
  #
  # Note that a file is not actually generated on the filesystem.
  #--
  # NOTE: One quirk of the Windows function is that, after the first call, it
  # adds a file extension of sequential numbers in base 32, e.g. .1-.1vvvvvu.
  #
  def self.temp_name
    if File::ALT_SEPARATOR
      ptr = FFI::MemoryPointer.new(:char, 1024)
      errno = tmpnam_s(ptr, ptr.size)

      raise SystemCallError.new('tmpnam_s', errno) if errno != 0

      TMPDIR + ptr.read_string + 'tmp'
    else
      tmpnam(nil) << '.tmp'
    end
  end

  private

  # For those times when we want the posix errno rather than a formatted string.
  # This is necessary because FFI.errno appears to be using GetLastError() which
  # does not always match what _get_errno() returns.
  #
  def get_posix_errno
    if File::ALT_SEPARATOR
      ptr = FFI::MemoryPointer.new(:int)
      _get_errno(ptr)
      ptr.read_int
    else
      FFI.errno
    end
  end

  if File::ALT_SEPARATOR
    # Simple wrapper around the GetTempPath function.
    #
    def get_temp_path
      buf = 0.chr * 1024
      buf.encode!("UTF-16LE")

      if GetTempPathW(buf.size, buf) == 0
        raise SystemCallError, FFI.errno, 'GetTempPathW'
      end

      buf.strip.chop # remove trailing slash
    end

    # The version of tmpfile() implemented by Microsoft is unacceptable.
    # It attempts to write to C:\ (root) instead of a temporary directory.
    # This is not only bad behavior, it won't work on Windows 7 and later
    # without admin rights due to security restrictions.
    #
    # This is a custom implementation based on some code from the Cairo
    # project.
    #
    def tmpfile
      file_name = get_temp_path()
      buf = 0.chr * 1024
      buf.encode!("UTF-16LE")

      if GetTempFileNameW(file_name, 'rb_', 0, buf) == 0
        raise SystemCallError, FFI.errno, 'GetTempFileNameW'
      end

      file_name = buf.strip

      handle = CreateFileW(
        file_name,
        GENERIC_READ | GENERIC_WRITE,
        0,
        nil,
        CREATE_ALWAYS,
        FILE_ATTRIBUTE_NORMAL | FILE_FLAG_DELETE_ON_CLOSE,
        0
      )

      if handle == INVALID_HANDLE_VALUE
        error = FFI.errno
        DeleteFileW(file_name)
        raise SystemCallError.new('CreateFileW', error)
      end

      fd = _open_osfhandle(handle, 0)

      if fd < 0
        CloseHandle(handle)
        raise SystemCallError, get_posix_errno, '_open_osfhandle'
      end

      fp = _fdopen(fd, 'w+b')

      if fp.nil?
        _close(fd)
        CloseHandle(handle)
        raise SystemCallError, get_posix_errno, 'fdopen'
      end

      fp
    end
  end
end
