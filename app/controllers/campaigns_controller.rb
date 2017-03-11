class CampaignsController < ApplicationController

  def show
    @campaign = Campaign.find_by_id(params[:id])
  end

end
