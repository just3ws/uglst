class NetworksController < ApplicationController
  def show
    @network = Network.friendly.find(params[:id])
  end
end
