class User < ActiveRecord::Base
  default_scope -> { order('created_at ASC') }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :send_welcome_email

  extend FriendlyId
  friendly_id :username, use: :slugged

  validates :username, presence: true, uniqueness: true

  has_many :user_groups_registered, foreign_key: 'registered_by_id', class_name: 'UserGroup'

  has_one :personal, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :personal, allow_destroy: true

  has_one :profile, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :profile, allow_destroy: true

  validates_presence_of :email

  def personal
    super || build_personal
  end

  def profile
    super || build_profile
  end

  def send_welcome_email
    WelcomeEmailJob.new.async.perform(id)
  end
end

# == Schema Information
# Schema version: 20140616040112
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  admin                  :boolean          default(FALSE)
#  email                  :string(255)      default(""), not null, indexed
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)      indexed
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  slug                   :string(255)      indexed
#  username               :string(255)      indexed
#  email_opt_in           :boolean          default(FALSE)
#  send_stickers          :boolean
#  stickers_sent_on       :date
#  created_at             :datetime         indexed
#  updated_at             :datetime
#
# Indexes
#
#  index_users_on_created_at            (created_at)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
