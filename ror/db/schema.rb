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

ActiveRecord::Schema.define(:version => 20100928161829) do

  create_table "ad_groups", :force => true do |t|
    t.string   "name",        :null => false
    t.integer  "campaign_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ads", :force => true do |t|
    t.integer  "ad_group_id",       :null => false
    t.integer  "template_type_id",  :null => false
    t.string   "title",             :null => false
    t.string   "description_line1", :null => false
    t.string   "description_line2", :null => false
    t.string   "description",       :null => false
    t.string   "display_url",       :null => false
    t.string   "destination_url",   :null => false
    t.boolean  "enabled",           :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ads_publishers", :id => false, :force => true do |t|
    t.integer "ad_id",        :null => false
    t.integer "publisher_id", :null => false
  end

  create_table "campaigns", :force => true do |t|
    t.string   "name",       :null => false
    t.boolean  "enabled",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publishers", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "website",      :null => false
    t.string   "phone",        :null => false
    t.string   "contact_name", :null => false
    t.string   "access_hash",  :null => false
    t.boolean  "enabled",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "serving_stats", :force => true do |t|
    t.integer  "publisher_id", :null => false
    t.integer  "template_id",  :null => false
    t.integer  "ad_id",        :null => false
    t.integer  "position",     :null => false
    t.integer  "time_served",  :null => false
    t.integer  "impressions",  :null => false
    t.integer  "clicks",       :null => false
    t.string   "hash",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "template_types", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "templates", :force => true do |t|
    t.integer  "type_id",    :null => false
    t.string   "name",       :null => false
    t.integer  "positions",  :null => false
    t.integer  "width",      :null => false
    t.integer  "height",     :null => false
    t.string   "file",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
