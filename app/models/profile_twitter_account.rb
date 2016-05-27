# frozen_string_literal: true
class ProfileTwitterAccount < ActiveRecord::Base
  belongs_to :profile
  belongs_to :twitter_account

  validates :profile, presence: true
  validates :twitter_account, presence: true
end

# == Schema Information
#
# Table name: profile_twitter_accounts
#
#  id                 :integer          not null, primary key
#  twitter_account_id :integer
#  profile_id         :uuid
#  created_at         :datetime
#  updated_at         :datetime
#
