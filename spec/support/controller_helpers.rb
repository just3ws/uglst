# frozen_string_literal: true
module ControllerHelpers
  def login_with(user = double('user'), scope = :user)
    current_user = "current_#{scope}".to_sym
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, scope: scope)
      allow(controller).to receive(current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(current_user).and_return(user)
    end
  end
end

require 'devise'

RSpec.configure do |c|
  c.include Devise::TestHelpers, type: :controller
  c.include Warden::Test::Helpers

  c.include ControllerHelpers, type: :controller
  Warden.test_mode!

  c.after do
    Warden.test_reset!
  end
end
