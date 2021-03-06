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

ActiveRecord::Schema.define(version: 2022_05_19_121559) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "address_line1"
    t.string "address_line2"
    t.string "address_city"
    t.string "address_state"
    t.string "address_zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "name"
    t.string "address_country", default: "US"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "letters", force: :cascade do |t|
    t.string "body"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "delivery_date"
    t.string "send_date"
    t.string "preview_url"
    t.bigint "to_id"
    t.bigint "from_id"
    t.index ["from_id"], name: "index_letters_on_from_id"
    t.index ["to_id"], name: "index_letters_on_to_id"
    t.index ["user_id"], name: "index_letters_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "google_id"
    t.string "password_digest"
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "letters", "addresses", column: "from_id"
  add_foreign_key "letters", "addresses", column: "to_id"
  add_foreign_key "letters", "users"
end
