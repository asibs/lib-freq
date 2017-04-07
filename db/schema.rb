# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170218182752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaign_links", force: :cascade do |t|
    t.integer  "campaign_id"
    t.string   "link_type"
    t.string   "url"
    t.boolean  "show_during_pledge"
    t.boolean  "show_during_buy"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["campaign_id"], name: "index_campaign_links_on_campaign_id", using: :btree
  end

  create_table "campaigns", force: :cascade do |t|
    t.string   "name"
    t.datetime "pledge_start"
    t.datetime "pledge_end"
    t.datetime "buy_start"
    t.datetime "buy_end"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["name"], name: "index_campaigns_on_name", unique: true, using: :btree
  end

  create_table "song_buys", force: :cascade do |t|
    t.integer  "song_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["song_id"], name: "index_song_buys_on_song_id", using: :btree
    t.index ["user_id", "song_id"], name: "index_song_buys_on_user_id_and_song_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_song_buys_on_user_id", using: :btree
  end

  create_table "song_links", force: :cascade do |t|
    t.integer  "song_id"
    t.string   "link_type"
    t.string   "url"
    t.boolean  "show_during_pledge"
    t.boolean  "show_during_buy"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["song_id"], name: "index_song_links_on_song_id", using: :btree
  end

  create_table "song_pledges", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "song_id"
    t.boolean  "confirmed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["song_id"], name: "index_song_pledges_on_song_id", using: :btree
    t.index ["user_id", "song_id"], name: "index_song_pledges_on_user_id_and_song_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_song_pledges_on_user_id", using: :btree
  end

  create_table "song_stats", force: :cascade do |t|
    t.integer  "song_id"
    t.integer  "pledge_count"
    t.integer  "buy_count"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["song_id"], name: "index_song_stats_on_song_id", unique: true, using: :btree
  end

  create_table "songs", force: :cascade do |t|
    t.integer  "campaign_id"
    t.string   "artist"
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["campaign_id"], name: "index_songs_on_campaign_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "uuid"
    t.string   "hashed_email"
    t.string   "encrypted_email"
    t.string   "encrypted_email_iv"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["hashed_email"], name: "index_users_on_hashed_email", unique: true, using: :btree
    t.index ["uuid"], name: "index_users_on_uuid", unique: true, using: :btree
  end

  add_foreign_key "campaign_links", "campaigns"
  add_foreign_key "song_buys", "songs"
  add_foreign_key "song_buys", "users"
  add_foreign_key "song_links", "songs"
  add_foreign_key "song_pledges", "songs"
  add_foreign_key "song_pledges", "users"
  add_foreign_key "song_stats", "songs"
  add_foreign_key "songs", "campaigns"
end
