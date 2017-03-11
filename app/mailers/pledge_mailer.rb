class PledgeMailer < ApplicationMailer

  def confirm_pledge_mail(email, confirmation_url, campaign, songs)
    @confirmation_url = confirmation_url
    @campaign = campaign
    @songs = songs

    mail(to: email, subject: campaign.name + " - Confirm your Song Pledges")
  end

end
