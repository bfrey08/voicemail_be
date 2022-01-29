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

ActiveRecord::Schema.define(version: 2022_01_27_202730) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "letters", force: :cascade do |t|
    t.string "to_address_line1"
    t.string "to_address_line2"
    t.string "to_address_city"
    t.string "to_address_state"
    t.string "to_address_zip"
    t.string "from_address_line1"
    t.string "from_address_line2"
    t.string "from_address_city"
    t.string "from_address_state"
    t.string "from_address_zip"
    t.string "body"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "to_name"
    t.string "from_name"
    t.string "delivery_date"
    t.string "send_date"
    t.string "preview_url"
    t.index ["user_id"], name: "index_letters_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "address_line1"
    t.string "address_line2"
    t.string "address_city"
    t.string "address_state"
    t.string "address_zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "google_id"
    t.string "password_digest"
  end

  add_foreign_key "letters", "users"
end
