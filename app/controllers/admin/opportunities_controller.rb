module Admin
  class OpportunitiesController < ApplicationController
    before_action :set_opportunity, only: [:show, :edit, :update, :destroy]

    respond_to :html

    def index
      @opportunities = Opportunity.all
      respond_with(@opportunities)
    end

    def show
      respond_with(@opportunity)
    end

    def new
      @opportunity = Opportunity.new
      respond_with(@opportunity)
    end

    def edit
    end

    def create
      @opportunity = Opportunity.new(opportunity_params)
      flash[:notice] = 'Opportunity was successfully created.' if @opportunity.save
      respond_with(@opportunity)
    end

    def update
      flash[:notice] = 'Opportunity was successfully updated.' if @opportunity.update(opportunity_params)
      respond_with(@opportunity)
    end

    def destroy
      @opportunity.destroy
      respond_with(@opportunity)
    end

    private

    def set_opportunity
      @opportunity = Opportunity.find(params[:id])
    end

    def opportunity_params
      params[:opportunity]
    end
  end
end
