class Domain::Social::TwitterAccount
  include Comparable

  def initialize(twitter)
    @screen_name = Domain::Social::TwitterParser.parse_screen_name(twitter)
    @user_id = Domain::Social::TwitterParser.lookup_user_id_for(@screen_name) if @screen_name.present?
  end

  def screen_name
    @screen_name
  end

  def user_id
    @user_id
  end

  def to_s
    @user_id.to_s
  end
end
