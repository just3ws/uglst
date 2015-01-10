class UserGroupTwitterAccount < ActiveRecord::Base
  belongs_to :user_group
  belongs_to :twitter_account

  validates :user_group, presence: true
  validates :twitter_account, presence: true
end

# == Schema Information
#
# Table name: user_group_twitter_accounts
#
#  id                 :integer          not null, primary key
#  user_group_id      :uuid
#  twitter_account_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#
