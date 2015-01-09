class ProfileTwitterAccount < ActiveRecord::Base
  belongs_to :profile
  belongs_to :twitter_account

  validates :profile, presence: true
  validates :twitter_account, presence: true
end
