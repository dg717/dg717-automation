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

ActiveRecord::Schema.define(version: 20160206013910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "card_keys", force: true do |t|
    t.integer  "user_id"
    t.string   "key_number"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "card_keys", ["user_id"], name: "index_card_keys_on_user_id", using: :btree

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "full_name"
    t.string   "domain"
    t.string   "url"
    t.text     "description"
    t.integer  "tel"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "chargeable",      default: true
    t.integer  "company_type"
    t.string   "logo"
    t.integer  "special_pricing"
  end

  add_index "companies", ["user_id"], name: "index_companies_on_user_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "event_type"
    t.text     "description"
    t.text     "subtext"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "space"
    t.boolean  "status"
  end

  create_table "external_services", force: true do |t|
    t.integer  "user_id"
    t.integer  "envoy_status"
    t.integer  "yaroom_status"
    t.integer  "google_status"
    t.integer  "meraki_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "external_services", ["user_id"], name: "index_external_services_on_user_id", using: :btree

  create_table "locker_keys", force: true do |t|
    t.integer  "user_id"
    t.integer  "key_number"
    t.integer  "locker_number"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locker_keys", ["user_id"], name: "index_locker_keys_on_user_id", using: :btree

  create_table "meetings", force: true do |t|
    t.integer  "user_id"
    t.integer  "room_id"
    t.integer  "modified_by"
    t.string   "name"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "duration"
    t.datetime "cancelled_at"
    t.datetime "yaroom_updated_at"
    t.integer  "yaroom_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted"
    t.datetime "deleted_at"
  end

  add_index "meetings", ["room_id"], name: "index_meetings_on_room_id", using: :btree
  add_index "meetings", ["user_id"], name: "index_meetings_on_user_id", using: :btree
  add_index "meetings", ["yaroom_id"], name: "index_meetings_on_yaroom_id", using: :btree

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.float    "cost"
    t.integer  "capacity"
    t.integer  "floor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trackings", force: true do |t|
    t.datetime "last_sent"
    t.integer  "last_total", default: 0
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_attributes", force: true do |t|
    t.integer  "user_id"
    t.text     "interest"
    t.string   "favorite_color"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_attributes", ["user_id"], name: "index_user_attributes_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",      default: "", null: false
    t.string   "first_name", default: "", null: false
    t.string   "last_name",  default: "", null: false
    t.integer  "yaroom_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "desk_type",  default: 0
    t.string   "avatar"
    t.datetime "start_date"
    t.datetime "end_date"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["yaroom_id"], name: "index_users_on_yaroom_id", using: :btree

end
