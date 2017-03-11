class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.string :name
      t.timestamp :pledge_start
      t.timestamp :pledge_end
      t.timestamp :buy_start
      t.timestamp :buy_end

      t.timestamps
    end
    add_index :campaigns, :name, unique: true
  end
end
