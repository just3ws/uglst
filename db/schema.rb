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

ActiveRecord::Schema.define(version: 20_140_609_184_344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'
  enable_extension 'fuzzystrmatch'
  enable_extension 'pg_trgm'
  enable_extension 'pgcrypto'
  enable_extension 'uuid-ossp'

  create_table 'friendly_id_slugs', force: true do |t|
    t.datetime 'created_at'
    t.integer 'sluggable_id', null: false
    t.string 'scope'
    t.string 'slug', null: false
    t.string 'sluggable_type', limit: 50
  end

  add_index 'friendly_id_slugs', %w(slug sluggable_type scope), name: 'index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope', unique: true, using: :btree
  add_index 'friendly_id_slugs', %w(slug sluggable_type), name: 'index_friendly_id_slugs_on_slug_and_sluggable_type', using: :btree
  add_index 'friendly_id_slugs', ['sluggable_id'], name: 'index_friendly_id_slugs_on_sluggable_id', using: :btree
  add_index 'friendly_id_slugs', ['sluggable_type'], name: 'index_friendly_id_slugs_on_sluggable_type', using: :btree

  create_table 'personals', id: :uuid, default: 'uuid_generate_v4()', force: true do |t|
    t.integer 'user_id'
    t.text 'birthday'
    t.text 'ethnicity'
    t.text 'gender'
    t.text 'parental_status'
    t.text 'race'
    t.text 'relationship_status'
    t.text 'religious_affiliation'
    t.text 'sexual_orientation'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'personals', ['user_id'], name: 'index_personals_on_user_id', using: :btree

  create_table 'user_groups', id: :uuid, default: 'uuid_generate_v4()', force: true do |t|
    t.uuid 'registered_by_id'
    t.string 'homepage'
    t.string 'name'
    t.string 'slug'
    t.string 'twitter'
    t.text 'description'
    t.text 'topics', array: true
    t.text 'address'
    t.text 'formatted_address'
    t.string 'city'
    t.string 'state_province'
    t.string 'country'
    t.string 'latitude'
    t.string 'longitude'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'users', id: :uuid, default: 'uuid_generate_v4()', force: true do |t|
    t.boolean 'admin', default: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.string 'username'
    t.string 'slug'
    t.string 'twitter'
    t.string 'homepage'
    t.string 'first_name'
    t.string 'last_name'
    t.boolean 'email_opt_in', default: false
    t.boolean 'send_stickers'
    t.date 'stickers_sent_on'
    t.string 'interests', array: true
    t.text 'bio'
    t.text 'address'
    t.text 'formatted_address'
    t.string 'city'
    t.string 'state_province'
    t.string 'country'
    t.float 'latitude'
    t.float 'longitude'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'users', ['email'], name: 'index_users_on_email', unique: true, using: :btree
  add_index 'users', %w(latitude longitude), name: 'index_users_on_latitude_and_longitude', using: :btree
  add_index 'users', ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true, using: :btree
  add_index 'users', ['slug'], name: 'index_users_on_slug', unique: true, using: :btree
  add_index 'users', ['username'], name: 'index_users_on_username', unique: true, using: :btree

end
