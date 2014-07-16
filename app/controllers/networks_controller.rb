class NetworksController < ApplicationController
  before_action :set_network, only: [:show, :edit, :update, :destroy, :join, :leave]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :join, :leave]

  def show
    @page_title = "#{@network.name} on Network List" if @network && @network.name
  end

  def index
    @networks = Network.order('created_at').reverse_order
    respond_to do |format|
      format.html { render :index }
      format.rss { render layout: nil }
    end
  end

  def edit
  end

  def new
    @network = current_user.networks_registered.build
  end

  def create
    @network = current_user.networks_registered.build(network_params)

    respond_to do |format|
      if @network.save
        format.html { redirect_to @network, notice: 'Network was successfully created.' }
        format.json { render :show, status: :created, location: @network }
      else
        format.html { render :new }
        format.json { render json: @network.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    unless current_user.admin? || @network.registered_by.id == current_user.id
      fail 'You may only update networks that you registered.'
    end

    respond_to do |format|
      if @network.update(network_params)
        format.html { redirect_to @network, notice: 'Network was successfully updated.' }
        format.json { render :show, status: :ok, location: @network }
      else
        format.html { render :edit }
        format.json { render json: @network.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    unless current_user.admin? || @network.registered_by.id == current_user.id
      fail 'You may only destroy Networks that you registered.'
    end

    @network.destroy

    respond_to do |format|
      format.html { redirect_to networks_url, notice: 'Network was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_network
    @network = Network.friendly.find(params[:id])
  end

  def network_params
    if current_user.admin?
      params.require(:network).permit!
    else
      params.require(:network).permit(
        :description,
        :homepage,
        :name,
        :twitter,
        :logo
      )
    end
  end
end
