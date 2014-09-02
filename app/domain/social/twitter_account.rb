class Domain::Social::TwitterAccount
  include Comparable

  def self.from_twitter_string(twitter)
    screen_name = Domain::Social::TwitterParser.parse_screen_name(twitter)

    user_id = if screen_name.present?
                Domain::Social::TwitterParser.lookup_user_id_for(@screen_name)
              end

    Domain::Social::TwitterAccount.new(screen_name, user_id)
  end

  attr_reader :screen_name

  def initialize(screen_name, user_id=nil)
    @screen_name = screen_name
    @user_id = user_id
  end

  def user_id
    @user_id ||= if screen_name.present?
                   Domain::Social::TwitterParser.lookup_user_id_for(screen_name)
                 end
  end

  def to_s
    user_id.to_s
  end

  def to_i
    user_id.to_i
  end

  def <=>(other)
    to_i <=> other.to_i
  end

  def hash
    to_i.hash
  end

  def eql?(other)
    to_i == other.to_i
  end
end
