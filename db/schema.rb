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
    t.text    "date"
    t.text    "time"
    t.text    "review"
    t.integer "points",        default: 0
    t.boolean "canceled",      default: false
    t.index ["restaurant_id"], name: "index_reservations_on_restaurant_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.text    "name"
    t.text    "city"
    t.text    "address"
    t.text    "dining_style"
    t.text    "cuisines"
    t.text    "price_range"
    t.text    "phone_number"
    t.text    "website"
    t.text    "description"
    t.text    "photo_url"
    t.integer "number_of_tables", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.text    "username"
    t.text    "password"
    t.text    "first_name"
    t.text    "last_name"
    t.text    "email"
    t.integer "points",     default: 0
    t.boolean "is_admin",   default: false
  end

end
