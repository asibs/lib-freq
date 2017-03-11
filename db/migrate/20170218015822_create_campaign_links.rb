class CreateCampaignLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :campaign_links do |t|
      t.references :campaign, foreign_key: true
      t.string :link_type
      t.string :url
      t.boolean :show_during_pledge
      t.boolean :show_during_buy

      t.timestamps
    end
  end
end
