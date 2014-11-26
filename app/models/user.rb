class User < ActiveRecord::Base
  include PublicActivity::Model
  tracked

  default_scope { order('created_at ASC') }

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :async, :confirmable

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

  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << 'cannot be blank' if password.blank?
    self.errors[:password_confirmation] << 'cannot be blank' if password_confirmation.blank?
    self.errors[:password_confirmation] << 'does not match password' if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  # new function to set the password without knowing the current password used in our confirmation controller.
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end

  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  # new function to provide access to protected method unless_confirmed
  def only_if_unconfirmed
    pending_any_confirmation { yield }
  end

  def password_required?
    # Password is required if it is being set, but not for new records
    if !persisted?
      false
    else
      !password.nil? || !password_confirmation.nil?
    end
  end
end

# == Schema Information
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
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#
