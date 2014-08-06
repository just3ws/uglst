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

ActiveRecord::Schema.define(version: 20140804223946) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "fuzzystrmatch"
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "uuid-ossp"
  enable_extension "pg_stat_statements"

  create_table "activities", force: true do |t|
    t.uuid     "trackable_id"
    t.string   "trackable_type"
    t.uuid     "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.uuid     "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.datetime "created_at"
    t.integer  "sluggable_id",              null: false
    t.string   "scope"
    t.string   "slug",                      null: false
    t.string   "sluggable_type", limit: 50
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "import_php_ugs", force: true do |t|
    t.integer  "php_ug_id"
    t.json     "php_ug_data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state",       default: 0
  end

  create_table "network_affiliations", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "network_id"
    t.uuid     "user_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "network_affiliations", ["network_id", "user_group_id"], name: "index_network_affiliations_on_network_id_and_user_group_id", using: :btree
  add_index "network_affiliations", ["network_id"], name: "index_network_affiliations_on_network_id", using: :btree
  add_index "network_affiliations", ["user_group_id"], name: "index_network_affiliations_on_user_group_id", using: :btree

  create_table "networks", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "registered_by_id"
    t.string   "homepage"
    t.text     "name"
    t.string   "slug"
    t.string   "twitter"
    t.text     "description"
    t.string   "logo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "networks", ["name"], name: "index_networks_on_name", using: :btree

  create_table "personals", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "user_id"
    t.text     "birthday"
    t.text     "ethnicity"
    t.text     "gender"
    t.text     "parental_status"
    t.text     "race"
    t.text     "relationship_status"
    t.text     "religious_affiliation"
    t.text     "sexual_orientation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "personals", ["created_at"], name: "index_personals_on_created_at", using: :btree

  create_table "profiles", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "user_id"
    t.string   "twitter"
    t.string   "homepage"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "interests",         array: true
    t.text     "bio"
    t.text     "address"
    t.text     "formatted_address"
    t.string   "city"
    t.string   "state_province"
    t.string   "country"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["created_at"], name: "index_profiles_on_created_at", using: :btree
  add_index "profiles", ["latitude", "longitude"], name: "index_profiles_on_latitude_and_longitude", using: :btree

  create_table "source_histories", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "source_id"
    t.uuid     "user_group_id"
    t.string   "remote_identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "source_histories", ["source_id", "user_group_id"], name: "index_source_histories_on_source_id_and_user_group_id", using: :btree
  add_index "source_histories", ["source_id"], name: "index_source_histories_on_source_id", using: :btree
  add_index "source_histories", ["user_group_id"], name: "index_source_histories_on_user_group_id", using: :btree

  create_table "sources", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "homepage"
    t.string   "twitter"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sources", ["name"], name: "index_sources_on_name", using: :btree
  add_index "sources", ["slug"], name: "index_sources_on_slug", using: :btree

  create_table "user_group_memberships", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "user_id"
    t.uuid     "user_group_id"
    t.integer  "relationship",  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_group_memberships", ["relationship"], name: "index_user_group_memberships_on_relationship", using: :btree
  add_index "user_group_memberships", ["user_group_id"], name: "index_user_group_memberships_on_user_group_id", using: :btree
  add_index "user_group_memberships", ["user_id", "user_group_id"], name: "index_user_group_memberships_on_user_id_and_user_group_id", using: :btree
  add_index "user_group_memberships", ["user_id"], name: "index_user_group_memberships_on_user_id", using: :btree

  create_table "user_groups", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "registered_by_id"
    t.string   "homepage"
    t.string   "name"
    t.string   "slug"
    t.string   "twitter"
    t.text     "description"
    t.text     "topics",            array: true
    t.text     "address"
    t.text     "formatted_address"
    t.string   "city"
    t.string   "state_province"
    t.string   "country"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "logo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_groups", ["created_at"], name: "index_user_groups_on_created_at", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.boolean  "admin",                  default: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "slug"
    t.string   "username"
    t.boolean  "email_opt_in",           default: false
    t.boolean  "send_stickers"
    t.date     "stickers_sent_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["created_at"], name: "index_users_on_created_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
