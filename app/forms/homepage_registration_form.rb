class HomepageRegistrationForm
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
end
