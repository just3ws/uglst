class User < ActiveRecord::Base
  rolify
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
  # , :confirmable

  extend FriendlyId
  friendly_id :username, use: :slugged

  validates :username,
            uniqueness: true,
            length: { in: 1..15 },
            username_convention: true,
            allow_nil: true

  has_one :personal, dependent: :destroy, inverse_of: :user
  has_one :profile,  dependent: :destroy, inverse_of: :user

  has_many :networks_registered, foreign_key: 'registered_by_id', class_name: 'Network'

  has_many :user_group_memberships
  has_many :user_groups, through: :user_group_memberships
  has_many :user_groups_registered, foreign_key: 'registered_by_id', class_name: 'UserGroup'

  accepts_nested_attributes_for :personal, allow_destroy: true
  accepts_nested_attributes_for :profile,  allow_destroy: true

  validates :email, presence: true

  before_create :build_default_profile
  before_create :build_default_personal

  def personal
    super || build_personal
  end

  def profile
    super || build_profile
  end

  private

  def build_default_profile
    # build default profile instance. Will use default params.
    # The foreign key to the owning User model is set automatically
    build_profile
    true # Always return true in callbacks as the normal 'continue' state
    # Assumes that the default_profile can **always** be created.
    # or
    # Check the validation of the profile. If it is not valid, then
    # return false from the callback. Best to use a before_validation
    # if doing this. View code should check the errors of the child.
    # Or add the child's errors to the User model's error array of the :base
    # error item
  end

  def build_default_personal
    # build default personal instance. Will use default params.
    # The foreign key to the owning User model is set automatically
    build_personal
    true # Always return true in callbacks as the normal 'continue' state
    # Assumes that the default_personal can **always** be created.
    # or
    # Check the validation of the personal. If it is not valid, then
    # return false from the callback. Best to use a before_validation
    # if doing this. View code should check the errors of the child.
    # Or add the child's errors to the User model's error array of the :base
    # error item
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  admin                  :boolean          default("false")
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  slug                   :string
#  username               :string
#  email_opt_in           :boolean          default("false")
#  send_stickers          :boolean
#  stickers_sent_on       :date
#  created_at             :datetime
#  updated_at             :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#
