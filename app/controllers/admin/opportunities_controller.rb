class Admin::OpportunitiesController < ApplicationController
  before_action :set_admin_opportunity, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @admin_opportunities = Admin::Opportunity.all
    respond_with(@admin_opportunities)
  end

  def show
    respond_with(@admin_opportunity)
  end

  def new
    @admin_opportunity = Admin::Opportunity.new
    respond_with(@admin_opportunity)
  end

  def edit
  end

  def create
    @admin_opportunity = Admin::Opportunity.new(opportunity_params)
    flash[:notice] = 'Admin::Opportunity was successfully created.' if @admin_opportunity.save
    respond_with(@admin_opportunity)
  end

  def update
    flash[:notice] = 'Admin::Opportunity was successfully updated.' if @admin_opportunity.update(opportunity_params)
    respond_with(@admin_opportunity)
  end

  def destroy
    @admin_opportunity.destroy
    respond_with(@admin_opportunity)
  end

  private

  def set_admin_opportunity
    @admin_opportunity = Admin::Opportunity.find(params[:id])
  end

  def admin_opportunity_params
    params[:admin_opportunity]
  end
end
