# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170509232004) do

  create_table "api_players", force: :cascade do |t|
    t.string   "player_name"
    t.string   "commonName"
    t.string   "firstName"
    t.string   "lastName"
    t.string   "quality"
    t.string   "color"
    t.boolean  "isGK",               default: false
    t.string   "baseId"
    t.string   "playerdb_id"
    t.string   "rating"
    t.string   "league"
    t.string   "league_abbr"
    t.string   "nation"
    t.string   "nation_img_small"
    t.string   "nation_img_large"
    t.string   "club"
    t.string   "club_img_small"
    t.string   "club_img_large"
    t.string   "headshot_img_small"
    t.string   "headshot_img_large"
    t.string   "special_img_small"
    t.string   "special_img_large"
    t.string   "position"
    t.string   "height"
    t.string   "weight"
    t.string   "birthdate"
    t.string   "age"
    t.string   "acceleration"
    t.string   "aggression"
    t.string   "agility"
    t.string   "balance"
    t.string   "ballcontrol"
    t.string   "foot"
    t.string   "skillMoves"
    t.string   "crossing"
    t.string   "curve"
    t.string   "dribbling"
    t.string   "finishing"
    t.string   "freekickaccuracy"
    t.string   "gkdiving"
    t.string   "gkhandling"
    t.string   "gkkicking"
    t.string   "gkpositioning"
    t.string   "gkreflexes"
    t.string   "headingaccuracy"
    t.string   "interceptions"
    t.string   "jumping"
    t.string   "longpassing"
    t.string   "longshots"
    t.string   "marking"
    t.string   "penalties"
    t.string   "positioning"
    t.string   "potential"
    t.string   "reactions"
    t.string   "shortpassing"
    t.string   "shotpower"
    t.string   "slidingtackle"
    t.string   "sprintspeed"
    t.string   "standingtackle"
    t.string   "stamina"
    t.string   "strength"
    t.string   "vision"
    t.string   "volleys"
    t.string   "weakFoot"
    t.string   "traits"
    t.string   "specialities"
    t.string   "atkWorkRate"
    t.string   "defWorkRate"
    t.string   "playerType"
    t.string   "attr_1_name"
    t.string   "attr_2_name"
    t.string   "attr_3_name"
    t.string   "attr_4_name"
    t.string   "attr_5_name"
    t.string   "attr_6_name"
    t.string   "attr_1_val"
    t.string   "attr_2_val"
    t.string   "attr_3_val"
    t.string   "attr_4_val"
    t.string   "attr_5_val"
    t.string   "attr_6_val"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "player"
    t.string   "url"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "buy"
    t.integer  "sell"
    t.boolean  "mail"
    t.integer  "user_id"
    t.integer  "current"
    t.boolean  "buyed",      default: false
    t.string   "img"
    t.string   "tp"
    t.boolean  "notif",      default: false
    t.boolean  "track",      default: false
  end

  add_index "players", ["user_id"], name: "index_players_on_user_id"

  create_table "prices", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "prices", ["player_id"], name: "index_prices_on_player_id"

  create_table "sales", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "sell_in"
    t.float    "afterTax"
    t.float    "pMargin"
    t.float    "nMargin"
    t.float    "buy_in"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sales", ["player_id"], name: "index_sales_on_player_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                  default: false
    t.string   "auth_token"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
