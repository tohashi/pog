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

ActiveRecord::Schema.define(version: 20141105123729) do

  create_table "contents", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents_piles", force: true do |t|
    t.integer  "content_id", null: false
    t.integer  "pile_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "piles", force: true do |t|
    t.integer  "user_id",                null: false
    t.string   "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",     default: 0, null: false
  end

  create_table "piles_platforms", force: true do |t|
    t.integer  "pile_id"
    t.integer  "platform_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "piles_platforms", ["pile_id"], name: "index_piles_platforms_on_pile_id", using: :btree
  add_index "piles_platforms", ["platform_id"], name: "index_piles_platforms_on_platform_id", using: :btree

  create_table "platforms", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",       default: "guest", null: false
    t.integer  "authority",  default: 1,       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
  end

end
