class HomepageRegistrationForm # < Reform::Form
  include ActiveModel::Model
  include Virtus.model

  attribute :name, String
  attribute :address, String
  attribute :homepage, String

  attribute :email, String
  attribute :password, String

  validates :name,     presence: true
  validates :address,  presence: true
  validates :email,    presence: true
  validates :password, presence: true

  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  # property :name, validates: {presence: true}, on: :user_group
  # property :address, validates: {presence: true}, on: :user_group
  # property :homepage, on: :user_group

  # property :email, validates: {presence: true}, on: :user
  # property :password, validates: {presence: true}, on: :user
end
