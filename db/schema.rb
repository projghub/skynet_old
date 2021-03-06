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

ActiveRecord::Schema.define(:version => 20101108225918) do

  create_table "accounts", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "email",      :null => false
    t.boolean  "enabled",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "accounts", ["enabled"], :name => "index_accounts_on_enabled"

  create_table "ad_groups", :force => true do |t|
    t.string   "name",        :null => false
    t.integer  "campaign_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.datetime "deleted_at"
  end

  create_table "ad_types", :force => true do |t|
    t.string "name",  :null => false
    t.string "label", :null => false
  end

  create_table "ads", :force => true do |t|
    t.integer  "ad_group_id",                                                          :null => false
    t.integer  "ad_type_id"
    t.string   "title",                                                                :null => false
    t.string   "description_line1",                                                    :null => false
    t.string   "description_line2",                                                    :null => false
    t.string   "description",                                                          :null => false
    t.string   "display_url",                                                          :null => false
    t.string   "destination_url",                                                      :null => false
    t.string   "media_url"
    t.integer  "bid_type_id",                                                          :null => false
    t.decimal  "bid",                :precision => 10, :scale => 2,                    :null => false
    t.decimal  "daily_limit"
    t.boolean  "enabled",                                                              :null => false
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.datetime "deleted_at"
    t.boolean  "geolocate",                                         :default => false, :null => false
  end

  create_table "ads_attribute_values", :id => false, :force => true do |t|
    t.integer "ad_id",              :null => false
    t.integer "attribute_value_id", :null => false
  end

  add_index "ads_attribute_values", ["ad_id", "attribute_value_id"], :name => "ad_id_attribute_value_id_index", :unique => true

  create_table "ads_publishers", :id => false, :force => true do |t|
    t.integer "ad_id",        :null => false
    t.integer "publisher_id", :null => false
  end

  add_index "ads_publishers", ["ad_id", "publisher_id"], :name => "ad_id_publisher_id_index", :unique => true

  create_table "attribute_values", :force => true do |t|
    t.integer  "attribute_id", :null => false
    t.string   "value",        :null => false
    t.string   "label",        :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "attribute_values", ["attribute_id", "value"], :name => "attribute_id_value_index", :unique => true

  create_table "attributes", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "label",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "attributes", ["name"], :name => "name_index", :unique => true

  create_table "bid_types", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "label",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "campaigns", :force => true do |t|
    t.string   "name",       :null => false
    t.boolean  "enabled",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "account_id"
    t.datetime "deleted_at"
  end

  create_table "publishers", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "website",      :null => false
    t.string   "phone",        :null => false
    t.string   "contact_name", :null => false
    t.string   "access_hash",  :null => false
    t.boolean  "enabled",      :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.datetime "deleted_at"
  end

  create_table "serving_stats", :force => true do |t|
    t.integer  "publisher_id",                                                 :null => false
    t.integer  "template_id",                                                  :null => false
    t.integer  "ad_id",                                                        :null => false
    t.integer  "position",                                                     :null => false
    t.integer  "time_served",                                                  :null => false
    t.integer  "impressions",                                                  :null => false
    t.integer  "clicks",                                                       :null => false
    t.string   "hash",                                                         :null => false
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.decimal  "spent",        :precision => 13, :scale => 5, :default => 0.0, :null => false
  end

  create_table "template_types", :force => true do |t|
    t.string "name",  :null => false
    t.string "label"
  end

  create_table "templates", :force => true do |t|
    t.integer  "ad_type_id"
    t.string   "name",       :null => false
    t.integer  "positions",  :null => false
    t.integer  "width",      :null => false
    t.integer  "height",     :null => false
    t.string   "file",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "base_ad_id"
  end

  add_index "templates", ["base_ad_id"], :name => "base_ad_id_index"

  create_table "users", :force => true do |t|
    t.integer  "account_id",    :null => false
    t.string   "username",      :null => false
    t.string   "password_hash", :null => false
    t.string   "salt",          :null => false
    t.string   "email",         :null => false
    t.boolean  "enabled",       :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.datetime "deleted_at"
  end

  add_index "users", ["account_id"], :name => "index_users_on_account_id"
  add_index "users", ["username", "enabled"], :name => "index_users_on_username_and_enabled", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
