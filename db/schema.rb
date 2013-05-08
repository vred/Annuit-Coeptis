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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130508022423) do

  create_table "comments", :force => true do |t|
    t.string   "comment"
    t.integer  "user_id"
    t.integer  "comment_type"
    t.integer  "location_id"
    t.datetime "posted_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.boolean  "private"
    t.integer  "capital_cents",       :default => 0,     :null => false
    t.string   "capital_currency",    :default => "USD", :null => false
    t.integer  "margin_cents",        :default => 0,     :null => false
    t.string   "margin_currency",     :default => "USD", :null => false
    t.integer  "commission_cents",    :default => 0,     :null => false
    t.string   "commission_currency", :default => "USD", :null => false
    t.integer  "member_limit"
    t.integer  "portfolios_count",    :default => 0
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "creator_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "description"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
  end

  add_index "leagues", ["creator_id"], :name => "index_leagues_on_creator_id"

  create_table "markets", :force => true do |t|
    t.string   "name"
    t.datetime "date"
    t.integer  "price_cents",    :default => 0,     :null => false
    t.string   "price_currency", :default => "USD", :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "messages", :force => true do |t|
    t.string   "message"
    t.integer  "senderID"
    t.integer  "recipientID"
    t.datetime "date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "username"
  end

  create_table "orders", :force => true do |t|
    t.string   "ticker"
    t.integer  "price_executed_cents",     :default => 0,     :null => false
    t.string   "price_executed_currency",  :default => "USD", :null => false
    t.integer  "threshold_price_cents",    :default => 0,     :null => false
    t.string   "threshold_price_currency", :default => "USD", :null => false
    t.integer  "quantity"
    t.string   "type"
    t.datetime "time_placed"
    t.datetime "time_filled"
    t.integer  "duration_valid"
    t.boolean  "valid_order"
    t.string   "trade_type"
    t.integer  "portfolio_id"
    t.integer  "league_id"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "orders", ["portfolio_id", "league_id"], :name => "index_orders_on_portfolio_id_and_league_id"

  create_table "performances", :force => true do |t|
    t.date     "date"
    t.integer  "closing_value_cents",      :default => 0,     :null => false
    t.string   "closing_value_currency",   :default => "USD", :null => false
    t.integer  "closing_capital_cents",    :default => 0,     :null => false
    t.string   "closing_capital_currency", :default => "USD", :null => false
    t.integer  "closing_margin_cents",     :default => 0,     :null => false
    t.string   "closing_margin_currency",  :default => "USD", :null => false
    t.integer  "portfolio_id"
    t.integer  "league_id"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "portfolios", :force => true do |t|
    t.boolean  "manager",          :default => false
    t.integer  "capital_cents",    :default => 0,     :null => false
    t.string   "capital_currency", :default => "USD", :null => false
    t.integer  "margin_cents",     :default => 0,     :null => false
    t.string   "margin_currency",  :default => "USD", :null => false
    t.integer  "user_id"
    t.integer  "league_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "portfolios", ["user_id", "league_id"], :name => "index_portfolios_on_user_id_and_league_id"

  create_table "users", :force => true do |t|
    t.string   "name",                   :default => "",    :null => false
    t.boolean  "admin",                  :default => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
