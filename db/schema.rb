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

ActiveRecord::Schema.define(version: 20150205025335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "year_month"
  end

  create_table "counties", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "UTC_offset"
  end

  create_table "cuisine_lookups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dishes", force: :cascade do |t|
    t.string   "name"
    t.string   "cuisine"
    t.integer  "battle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "dishes", ["battle_id"], name: "index_dishes_on_battle_id", using: :btree

  create_table "potential_dishes", force: :cascade do |t|
    t.string   "name"
    t.string   "cuisine"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "restaurants", force: :cascade do |t|
    t.integer  "battle_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "name"
    t.string   "location"
    t.string   "phone"
    t.string   "yelp_rating_photo_url"
    t.string   "yelp_photo_url"
  end

  add_index "restaurants", ["battle_id"], name: "index_restaurants_on_battle_id", using: :btree

  create_table "suggestions", force: :cascade do |t|
    t.integer  "potential_dish_id"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "suggestions", ["potential_dish_id"], name: "index_suggestions_on_potential_dish_id", using: :btree
  add_index "suggestions", ["user_id"], name: "index_suggestions_on_user_id", using: :btree

  create_table "trash_talks", force: :cascade do |t|
    t.string   "trash"
    t.integer  "user_id"
    t.integer  "battle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "trash_talks", ["battle_id"], name: "index_trash_talks_on_battle_id", using: :btree
  add_index "trash_talks", ["user_id"], name: "index_trash_talks_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "county_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "is_admin",        default: false
    t.string   "token"
  end

  add_index "users", ["county_id"], name: "index_users_on_county_id", using: :btree

  create_table "votes", force: :cascade do |t|
    t.string   "comment"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "votes", ["restaurant_id"], name: "index_votes_on_restaurant_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

end
