# -*- encoding: utf-8 -*-
# stub: file-temp 1.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "file-temp"
  s.version = "1.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Daniel J. Berger"]
  s.date = "2014-02-17"
  s.description = "    The file-temp library provides an alternative approach to generating\n    temporary files. Features included improved security, a superior\n    interface, and better support for MS Windows.\n"
  s.email = "djberg96@gmail.com"
  s.extra_rdoc_files = ["CHANGES", "README", "MANIFEST"]
  s.files = ["CHANGES", "MANIFEST", "README"]
  s.homepage = "http://github.com/djberg96/file-temp"
  s.licenses = ["Artistic 2.0"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubyforge_project = "shards"
  s.rubygems_version = "2.4.5"
  s.summary = "An alternative way to generate temp files"

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ffi>, [">= 1.0.0"])
      s.add_development_dependency(%q<test-unit>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<ffi>, [">= 1.0.0"])
      s.add_dependency(%q<test-unit>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<ffi>, [">= 1.0.0"])
    s.add_dependency(%q<test-unit>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
