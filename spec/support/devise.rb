# https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
include Warden::Test::Helpers
Warden.test_mode!

RSpec.configure do |c|
  c.include Devise::TestHelpers, type: :controller
  c.include Devise::TestHelpers, type: :routing
end

def sign_in_participant(_user = nil)
  @participant = FactoryGirl.build(:participant)
  @participant.save!
  sign_in @participant
end

def sign_in_administrator(_user = nil)
  @administrator = FactoryGirl.build(:administrator)
  @administrator.save!
  sign_in @administrator
end
