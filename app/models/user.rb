class User < ActiveRecord::Base
  include PublicActivity::Model
  tracked

  default_scope { order('created_at ASC') }

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :async

  extend FriendlyId
  friendly_id :username, use: :slugged

  validates :username,
    uniqueness: true,
    length: { in: 1..15 },
    username_convention: true,
    allow_nil: true

  has_one :personal, dependent: :destroy, inverse_of: :user
  has_one :profile, dependent: :destroy, inverse_of: :user

  has_many :networks_registered, foreign_key: 'registered_by_id', class_name: 'Network'

  has_many :user_group_memberships
  has_many :user_groups, through: :user_group_memberships
  has_many :user_groups_registered, foreign_key: 'registered_by_id', class_name: 'UserGroup'

  accepts_nested_attributes_for :personal, allow_destroy: true
  accepts_nested_attributes_for :profile, allow_destroy: true

  validates :email, presence: true

  def personal
    super || build_personal
  end

  def profile
    super || build_profile
  end
end

# == Schema Information
# Schema version: 20141029053516
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  admin                  :boolean          default(FALSE)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  slug                   :string(255)
#  username               :string(255)
#  email_opt_in           :boolean          default(FALSE)
#  send_stickers          :boolean
#  stickers_sent_on       :date
#  created_at             :datetime
#  updated_at             :datetime
#
