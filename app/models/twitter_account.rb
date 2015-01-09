class TwitterAccount < ActiveRecord::Base
  validates_presence_of :screen_name, if: -> { user_id.nil? }
  validates_presence_of :user_id, if: -> { screen_name.blank? }

  validates_uniqueness_of :screen_name, allow_blank: true
  validates_uniqueness_of :user_id, allow_blank: true

  has_one :profile_twitter_account
  has_one :profile, through: :profile_twitter_account

  # has_one :user_group_twitter_account
  # has_one :user_group, through: :user_group_twitter_account

  before_save :lookup_user_id, if: :screen_name_changed?
  before_save :lookup_screen_name, if: :user_id_changed?

  def lookup_user_id
    response = Uglst::Clients::Twitter.new.client.user(screen_name)

    self.screen_name = response.screen_name
    self.user_id = Integer(response.id.to_s)

    self.data = response.as_json
  end

  def lookup_screen_name
    response = Uglst::Clients::Twitter.new.client.user(user_id)

    self.screen_name = response.screen_name
    self.user_id = Integer(response.id.to_s)

    self.data = response.as_json
  end
end

# == Schema Information
#
# Table name: twitter_accounts
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  screen_name :string(255)
#  data        :json
#  created_at  :datetime
#  updated_at  :datetime
#
