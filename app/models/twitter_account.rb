class TwitterAccount < ActiveRecord::Base
  validates :screen_name, presence: true, uniqueness: true
  validates :user_id, presence: true, uniqueness: true
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
