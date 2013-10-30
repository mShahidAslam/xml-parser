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

ActiveRecord::Schema.define(:version => 20131022195921) do

  create_table "agent_properties", :force => true do |t|
    t.integer  "property_id"
    t.integer  "agent_id"
    t.string   "status"
    t.integer  "update_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agent_properties", ["agent_id"], :name => "index_agent_properties_on_agent_id"
  add_index "agent_properties", ["property_id"], :name => "index_agent_properties_on_property_id"

  create_table "agents", :force => true do |t|
    t.string   "agent_unique_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "property_values", :force => true do |t|
    t.integer  "agent_property_id"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "property_values", ["agent_property_id"], :name => "index_property_values_on_agent_property_id"

end
