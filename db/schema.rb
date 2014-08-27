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

ActiveRecord::Schema.define(version: 20140826172227) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "available_dates", force: true do |t|
    t.integer  "listing_id", null: false
    t.date     "date",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "available_dates", ["listing_id"], name: "index_available_dates_on_listing_id", using: :btree

  create_table "listings", force: true do |t|
    t.string   "city"
    t.string   "address"
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "reservations", force: true do |t|
    t.integer  "listing_id", null: false
    t.integer  "user_id",    null: false
    t.date     "date",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reservations", ["listing_id"], name: "index_reservations_on_listing_id", using: :btree
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id", using: :btree

  create_table "reviews", force: true do |t|
    t.integer  "reservation_id"
    t.text     "body",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["reservation_id"], name: "index_reviews_on_reservation_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                               null: false
    t.string   "password_digest",                     null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "admin",               default: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "biography"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
