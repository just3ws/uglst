# frozen_string_literal: true
FactoryGirl.define do
  factory :user_group_twitter_account do
    user_group_id ''
    twitter_account_id 1
  end
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
