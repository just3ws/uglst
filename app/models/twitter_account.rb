class TwitterAccount < ActiveRecord::Base
  validates :screen_name, presence: true, if: -> { user_id.nil? }
  validates :user_id, presence: true, if: -> { screen_name.blank? }

  validates :screen_name, uniqueness: true, allow_blank: true, case_sensitive: false
  validates :user_id, uniqueness: true, allow_blank: true

  has_one :profile_twitter_account
  has_one :profile, through: :profile_twitter_account

  has_one :user_group_twitter_account
  has_one :user_group, through: :user_group_twitter_account

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
#  screen_name :string
#  data        :json
#  created_at  :datetime
#  updated_at  :datetime
#
