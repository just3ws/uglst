require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  describe "GET 'pricing'" do
    it "returns http success" do
      get 'pricing'
      expect(response).to be_success
    end
  end

end
