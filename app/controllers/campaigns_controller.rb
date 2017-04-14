class CampaignsController < ApplicationController

  before_action { @page = :home }

  def show
    campaign_id = params[:id] || 1
    @campaign = Campaign.find_by_id(campaign_id)
  end

end
