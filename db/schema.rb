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

ActiveRecord::Schema.define(version: 2019_02_09_043014) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.bigint "site_id"
    t.string "username"
    t.string "firstname"
    t.string "lastname"
    t.string "password_digest"
    t.boolean "super", default: false
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_admin_users_on_site_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "site_id"
    t.index ["site_id"], name: "index_appointments_on_site_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "domain"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "homepage", default: "homepage"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "firstname"
    t.string "lastname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.bigint "site_id"
    t.index ["site_id"], name: "index_users_on_site_id"
  end

  add_foreign_key "appointments", "sites"
  add_foreign_key "users", "sites"
end
