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

ActiveRecord::Schema.define(version: 0) do

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "restaurant_id"
    t.string  "date"
    t.string  "time"
    t.text    "review"
    t.boolean "canceled",      default: false
    t.integer "tables",        default: 0
    t.index ["restaurant_id"], name: "index_reservations_on_restaurant_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string  "name"
    t.string  "city"
    t.text    "address"
    t.string  "dining_style"
    t.string  "cuisines"
    t.string  "price_range"
    t.string  "phone_number"
    t.string  "website"
    t.text    "description"
    t.text    "photo_url"
    t.integer "number_of_tables", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string  "username"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "email"
    t.integer "points",          default: 0
    t.boolean "is_admin",        default: false
    t.string  "password_digest"
  end

end
