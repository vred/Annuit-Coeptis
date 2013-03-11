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

ActiveRecord::Schema.define(:version => 20130217084534) do

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.boolean  "private"
    t.decimal  "money"
    t.decimal  "margin"
    t.decimal  "commission"
    t.integer  "limits"
    t.date     "start"
    t.date     "end"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "leagues", ["user_id"], :name => "index_leagues_on_user_id"

  create_table "markets", :force => true do |t|
    t.string   "name"
    t.datetime "date"
    t.decimal  "price"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "orders", :force => true do |t|
    t.string   "name"
    t.decimal  "price"
    t.integer  "quantity"
    t.string   "type"
    t.datetime "placed"
    t.datetime "filled"
    t.integer  "valid"
    t.integer  "portfolio_id"
    t.integer  "league_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "orders", ["portfolio_id", "league_id"], :name => "index_orders_on_portfolio_id_and_league_id"

  create_table "portfolios", :force => true do |t|
    t.string   "role"
    t.decimal  "capital"
    t.decimal  "margin"
    t.integer  "user_id"
    t.integer  "league_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "portfolios", ["user_id", "league_id"], :name => "index_portfolios_on_user_id_and_league_id"

  create_table "users", :force => true do |t|
    t.string   "name",                   :default => "", :null => false
    t.boolean  "admin"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
