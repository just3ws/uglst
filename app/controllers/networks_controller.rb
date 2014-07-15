class NetworksController < ApplicationController
  def show
    @network = Network.friendly.find(params[:id])
  end

  def index
    @networks = Network.order('created_at').reverse_order
    respond_to do |format|
      format.html { render :index }
      format.rss { render layout: nil }
    end
  end
end
