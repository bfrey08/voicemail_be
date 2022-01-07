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

ActiveRecord::Schema.define(version: 2022_01_07_173844) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "letters", force: :cascade do |t|
    t.string "to_street_address_1"
    t.string "to_street_address_2"
    t.string "to_city"
    t.string "to_state"
    t.string "to_zip"
    t.string "from_street_address_1"
    t.string "from_street_address_2"
    t.string "from_city"
    t.string "from_state"
    t.string "from_zip"
    t.string "body"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "to_name"
    t.string "from_name"
    t.string "delivery_date"
    t.string "send_date"
    t.index ["user_id"], name: "index_letters_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "frontend_id"
    t.string "full_name"
    t.string "street_address_1"
    t.string "street_address_2"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "letters", "users"
end
