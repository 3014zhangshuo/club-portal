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

ActiveRecord::Schema.define(:version => 20120309081305) do

  create_table "cities", :force => true do |t|
    t.string "name", :null => false
  end

  add_index "cities", ["name"], :name => "index_cities_on_name", :unique => true

  create_table "club_types", :force => true do |t|
    t.string "name"
  end

  add_index "club_types", ["name"], :name => "index_club_types_on_name", :unique => true

  create_table "clubs", :force => true do |t|
    t.string   "name",                                 :null => false
    t.string   "permalink",                            :null => false
    t.integer  "university_id",                        :null => false
    t.integer  "club_type_id",                         :null => false
    t.text     "intro"
    t.string   "state",         :default => "blocked", :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "clubs", ["club_type_id"], :name => "index_clubs_on_club_type_id"
  add_index "clubs", ["permalink"], :name => "index_clubs_on_permalink", :unique => true
  add_index "clubs", ["university_id"], :name => "index_clubs_on_university_id"

  create_table "memberships", :force => true do |t|
    t.integer  "profile_id",                        :null => false
    t.integer  "club_id",                           :null => false
    t.string   "note"
    t.integer  "role_level", :default => 10,        :null => false
    t.string   "state",      :default => "blocked", :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "memberships", ["club_id"], :name => "index_memberships_on_club_id"
  add_index "memberships", ["profile_id"], :name => "index_memberships_on_profile_id"

  create_table "profiles", :force => true do |t|
    t.integer  "user_id",       :null => false
    t.integer  "university_id", :null => false
    t.string   "name",          :null => false
    t.date     "birth"
    t.string   "mobile"
    t.string   "email"
    t.string   "qq"
    t.string   "stu_no"
    t.string   "gender"
    t.string   "hometown"
    t.text     "bio"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id", :unique => true

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "universities", :force => true do |t|
    t.integer "city_id", :null => false
    t.string  "name",    :null => false
  end

  add_index "universities", ["name"], :name => "index_universities_on_name", :unique => true

  create_table "users", :force => true do |t|
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
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
