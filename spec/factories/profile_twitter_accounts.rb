FactoryGirl.define do
  factory :profile_twitter_account, class: 'ProfileTwitterAccounts' do
    profile nil
    twitter_account nil
  end
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
