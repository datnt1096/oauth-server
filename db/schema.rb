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

ActiveRecord::Schema.define(version: 2019_12_10_074743) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "authorizations", force: :cascade do |t|
    t.bigint "user_id"
    t.uuid "oauth_app_id"
    t.string "authorize_code"
    t.string "token"
    t.string "token_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["oauth_app_id"], name: "index_authorizations_on_oauth_app_id"
    t.index ["user_id"], name: "index_authorizations_on_user_id"
  end

  create_table "oauth_apps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", null: false
    t.string "home_page", null: false
    t.string "secret_key", null: false
    t.text "description"
    t.string "callback_url", null: false
    t.string "token"
    t.datetime "token_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_oauth_apps_on_user_id"
  end

  create_table "recharges", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "amount", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recharges_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.string "image"
    t.integer "wallet", default: 0
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "authorizations", "oauth_apps"
  add_foreign_key "authorizations", "users"
  add_foreign_key "oauth_apps", "users"
  add_foreign_key "recharges", "users"
end
