# frozen_string_literal: true
class OpportunitiesController < ApplicationController
  before_action :set_opportunity, only: %i(show)

  respond_to :html

  def index
    @opportunities = Opportunity.all
    respond_with(@opportunities)
  end

  def show
    respond_with(@opportunity)
  end

  private

  def set_opportunity
    @opportunity = Opportunity.find(params[:id])
  end
end
