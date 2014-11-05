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

ActiveRecord::Schema.define(version: 20141105155020) do

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

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "api_keys", force: true do |t|
    t.string   "api_key",    limit: 16
    t.integer  "channel_id"
    t.integer  "user_id"
    t.boolean  "write_flag",            default: false
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "api_keys", ["api_key"], name: "index_api_keys_on_api_key", unique: true
  add_index "api_keys", ["channel_id"], name: "index_api_keys_on_channel_id"

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "article_image"
    t.string   "video"
  end

  create_table "authorizations", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "token"
    t.string   "secret"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channels", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "description"
    t.decimal  "latitude",                             precision: 15, scale: 10
    t.decimal  "longitude",                            precision: 15, scale: 10
    t.string   "field1"
    t.string   "field2"
    t.string   "field3"
    t.string   "field4"
    t.string   "field5"
    t.string   "field6"
    t.string   "field7"
    t.string   "field8"
    t.integer  "scale1"
    t.integer  "scale2"
    t.integer  "scale3"
    t.integer  "scale4"
    t.integer  "scale5"
    t.integer  "scale6"
    t.integer  "scale7"
    t.integer  "scale8"
    t.string   "elevation"
    t.integer  "last_entry_id"
    t.boolean  "public_flag",                                                    default: false
    t.string   "options1"
    t.string   "options2"
    t.string   "options3"
    t.string   "options4"
    t.string   "options5"
    t.string   "options6"
    t.string   "options7"
    t.string   "options8"
    t.boolean  "social",                                                         default: false
    t.string   "slug"
    t.string   "status"
    t.string   "url"
    t.string   "video_id"
    t.string   "video_type"
    t.boolean  "clearing",                                                       default: false, null: false
    t.integer  "ranking"
    t.string   "user_agent"
    t.string   "realtime_io_serial_number", limit: 36
    t.text     "metadata"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "channels", ["latitude", "longitude"], name: "index_channels_on_latitude_and_longitude"
  add_index "channels", ["public_flag", "last_entry_id", "updated_at"], name: "channels_public_viewable"
  add_index "channels", ["ranking", "updated_at"], name: "index_channels_on_ranking_and_updated_at"
  add_index "channels", ["realtime_io_serial_number"], name: "index_channels_on_realtime_io_serial_number"
  add_index "channels", ["slug"], name: "index_channels_on_slug"
  add_index "channels", ["user_id"], name: "index_channels_on_user_id"

  create_table "comments", force: true do |t|
    t.string   "commenter"
    t.text     "body"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id"

  create_table "feeds", force: true do |t|
    t.integer  "channel_id"
    t.string   "field1"
    t.string   "field2"
    t.string   "field3"
    t.string   "field4"
    t.string   "field5"
    t.string   "field6"
    t.string   "field7"
    t.string   "field8"
    t.integer  "entry_id"
    t.string   "status"
    t.decimal  "latitude",   precision: 15, scale: 10
    t.decimal  "longitude",  precision: 15, scale: 10
    t.string   "elevation"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeds", ["channel_id", "created_at"], name: "index_feeds_on_channel_id_and_created_at"
  add_index "feeds", ["channel_id", "entry_id"], name: "index_feeds_on_channel_id_and_entry_id"

  create_table "headers", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.integer  "thinghttp_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "headers", ["thinghttp_id"], name: "index_headers_on_thinghttp_id"

  create_table "plugins", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.text     "html"
    t.text     "css"
    t.text     "js"
    t.boolean  "public_flag", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plugins", ["user_id"], name: "index_plugins_on_user_id"

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["channel_id"], name: "index_taggings_on_channel_id"
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name"

  create_table "twitter_accounts", force: true do |t|
    t.string   "screen_name"
    t.integer  "user_id"
    t.integer  "twitter_id",  limit: 8
    t.string   "token"
    t.string   "secret"
    t.string   "api_key",     limit: 17, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "twitter_accounts", ["api_key"], name: "index_twitter_accounts_on_api_key"
  add_index "twitter_accounts", ["twitter_id"], name: "index_twitter_accounts_on_twitter_id"
  add_index "twitter_accounts", ["user_id"], name: "index_twitter_accounts_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "about"
    t.string   "authentication_token"
    t.string   "image"
    t.string   "location"
    t.string   "username"
    t.string   "avatar"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
