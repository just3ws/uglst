# TODO: Lock down User to be only for the main login account.
#       Profiles are the primary reference because long-term
#       a User will be able to have multiple Profiles.
class User < ActiveRecord::Base
  include PublicActivity::Model
  tracked

  default_scope { order('created_at ASC') }

  devise \
    :database_authenticatable,
    :recoverable,
    :registerable,
    :rememberable,
    :trackable,
    :validatable

  extend FriendlyId
  friendly_id :username, use: %i(slugged)

  validates :username,
            uniqueness: true,
            length: { in: 1..15 },
            username_convention: true,
            allow_nil: true

  has_one :profile, dependent: :destroy, inverse_of: :user

  has_many :networks_registered, foreign_key: 'registered_by_id', class_name: 'Network'

  # TODO: Move UserGroup memberships to Profile.
  has_many :user_group_memberships
  has_many :user_groups, through: :user_group_memberships

  # TODO: Move UserGroups registered to Profile.
  has_many :user_groups_registered, foreign_key: 'registered_by_id', class_name: 'UserGroup'

  validates :email, presence: true

  before_create :build_default_profile

  def profile
    super || build_profile
  end

  private

  def build_default_profile
    build_profile
    true # Always return true in callbacks as the normal 'continue' state
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  admin                  :boolean          default("false")
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  slug                   :string(255)
#  username               :string(255)
#  email_opt_in           :boolean          default("false")
#  send_stickers          :boolean
#  stickers_sent_on       :date
#  created_at             :datetime
#  updated_at             :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#
