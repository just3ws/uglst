class TwitterAccount < ActiveRecord::Base
  validates :screen_name, presence: true, uniqueness: true
  validates :user_id, presence: true, uniqueness: true
end
