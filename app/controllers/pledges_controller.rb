require 'securerandom'

class PledgesController < ApplicationController

  before_action { @page = nil }

  def create
    campaign = Campaign.find_by_id(params[:id])
    return unless validate_create_params(campaign, params)

    user = User.find_or_create(params[:email])

    pledged_songs = []

    params["song_ids"].each do |form_song_id|
      db_song = Song.find_by_id(form_song_id)
      if db_song
        begin
          song_pledge = SongPledge.create!(user_id: user.id, song_id: db_song.id, confirmed: false)
          pledged_songs.push(db_song)
        rescue ActiveRecord::RecordNotUnique
          # A user can only pledge for a song once, so just give up if this is a duplicate
        end
      end
    end

    if !pledged_songs.empty?
      logger.debug("Attempting to send email to [" + params[:email] + "]")

      # TODO: Build this in a better way
      confirm_url = "#{Rails.application.secrets.host}/campaigns/#{campaign.id.to_s}/pledges/#{user.uuid}"

      # TODO: Setup a proper ActiveJob
      PledgeMailer.confirm_pledge_mail(params[:email], confirm_url, campaign, pledged_songs).deliver_later
    end

    logger.debug("Success! Redirecting to [" + campaign_url(campaign) + "]")
    flash[:success] = "Pledge successful, you will receive an email shortly. Your pledge will not be counted until you click the confirmation link in the email."
    redirect_to campaign_url(campaign)
  end


  def show
    @campaign = Campaign.find_by_id(params[:id])

    confirmed_pledges = []
    unconfirmed_pledges = []

    if @campaign
      @user = User.find_by_uuid(params[:uuid])

      get_pledges!(@user, confirmed_pledges, unconfirmed_pledges)

      @confirmed_songs = get_songs(confirmed_pledges)
      @unconfirmed_songs = get_songs(unconfirmed_pledges)
    end
  end


  def confirm
    @campaign = Campaign.find_by_id(params[:id])
    return unless validate_campaign(@campaign)

    existing_pledges = []
    new_pledges = []

    if @campaign
      @user = User.find_by_uuid(params[:uuid])
      return unless validate_user(@user)

      get_pledges!(@user, existing_pledges, new_pledges)

      new_pledges.each do |pledge|
        pledge.confirm_and_update_song_counts
      end

      @new_songs = get_songs(new_pledges)
      @existing_songs = get_songs(existing_pledges)
    end
  end


  private
    def validate_campaign(campaign)
      if !campaign
        logger.debug("Didn't find campaign [" + params[:id] + "], redirecting back")
        flash[:error] = "Oops, something went wrong!"
        redirect_to :back
        return false
      end

      true
    end

    def validate_user(user)
      if !user
        logger.debug("Didn't find user [" + params[:uuid] + "], redirecting back")
        flash[:error] = "Oops, something went wrong!"
        redirect_to :back
        return false
      end

      true
    end

    def validate_create_params(campaign, params)
      return false unless validate_campaign(campaign)

      if !LibFreqUtils.validate_email?(params[:email])
        logger.debug("Invalid email address [" + params[:email] + "], redirecting to [" + campaign_url(campaign) + "]")
        flash[:error] = "Sorry, that email address doesn't look right to us"
        redirect_to campaign_url(campaign)
        return false
      end

      if !params["song_ids"] || params["song_ids"].empty?
        logger.debug("No songs selected, redirecting to [" + campaign_url(campaign) + "]")
        flash[:error] = "Sorry, you don't appear to have chosen any songs"
        redirect_to campaign_url(campaign)
        return false
      end

      true
    end


    def get_pledges!(user, confirmed, unconfirmed)
      pledges = ( user ? user.song_pledge.to_a : [] )
      pledges.each do |pledge|
        if pledge.confirmed
          confirmed.push(pledge)
        else
          unconfirmed.push(pledge)
        end
      end
    end


    def get_songs(pledges)
      pledges.map { |p| p.song }
    end
end
