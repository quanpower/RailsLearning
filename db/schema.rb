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

ActiveRecord::Schema.define(version: 20141106150314) do

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

  create_table "commands", force: true do |t|
    t.string   "command_string"
    t.integer  "position"
    t.integer  "talkback_id"
    t.datetime "executed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commands", ["talkback_id", "executed_at"], name: "index_commands_on_talkback_id_and_executed_at"

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "flags"
    t.integer  "user_id"
    t.string   "ip_address"
  end

  add_index "comments", ["channel_id"], name: "index_comments_on_channel_id"

  create_table "daily_feeds", force: true do |t|
    t.integer "channel_id"
    t.date    "date"
    t.string  "calculation", limit: 20
    t.string  "result"
    t.integer "field",       limit: 1
  end

  add_index "daily_feeds", ["channel_id", "date"], name: "index_daily_feeds_on_channel_id_and_date"

  create_table "devices", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "model"
    t.string   "ip_address"
    t.integer  "port"
    t.string   "mac_address"
    t.string   "local_ip_address"
    t.integer  "local_port"
    t.string   "default_gateway"
    t.string   "subnet_mask"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "devices", ["mac_address"], name: "index_devices_on_mac_address"
  add_index "devices", ["user_id"], name: "index_devices_on_user_id"

  create_table "events", force: true do |t|
    t.integer  "timecontrol_id"
    t.datetime "run_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["run_at"], name: "index_events_on_run_at"

  create_table "failedlogins", force: true do |t|
    t.string   "login"
    t.string   "password"
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "pipes", force: true do |t|
    t.string   "name",       null: false
    t.string   "url",        null: false
    t.string   "slug",       null: false
    t.string   "parse"
    t.integer  "cache"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pipes", ["slug"], name: "index_pipes_on_slug"

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

  create_table "reacts", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "react_type",            limit: 10
    t.integer  "run_interval"
    t.boolean  "run_on_insertion",                 default: true,        null: false
    t.datetime "last_run_at"
    t.integer  "channel_id"
    t.integer  "field_number"
    t.string   "condition",             limit: 15
    t.string   "condition_value"
    t.float    "condition_lat"
    t.float    "condition_long"
    t.float    "condition_elev"
    t.integer  "actionable_id"
    t.boolean  "last_result",                      default: false
    t.string   "actionable_type",                  default: "Thinghttp"
    t.string   "action_value"
    t.string   "latest_value"
    t.boolean  "activated",                        default: true
    t.boolean  "run_action_every_time",            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reacts", ["channel_id", "run_on_insertion"], name: "index_reacts_on_channel_id_and_run_on_insertion"
  add_index "reacts", ["channel_id"], name: "index_reacts_on_channel_id"
  add_index "reacts", ["run_interval"], name: "index_reacts_on_run_interval"
  add_index "reacts", ["user_id"], name: "index_reacts_on_user_id"

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

  create_table "talkbacks", force: true do |t|
    t.string   "api_key",    limit: 16
    t.integer  "user_id"
    t.string   "name"
    t.integer  "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "talkbacks", ["api_key"], name: "index_talkbacks_on_api_key"
  add_index "talkbacks", ["user_id"], name: "index_talkbacks_on_user_id"

  create_table "thinghttps", force: true do |t|
    t.integer  "user_id"
    t.string   "api_key",      limit: 16
    t.text     "url"
    t.string   "auth_name"
    t.string   "auth_pass"
    t.string   "method"
    t.string   "content_type"
    t.string   "http_version"
    t.string   "host"
    t.text     "body"
    t.string   "name"
    t.string   "parse"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thinghttps", ["api_key"], name: "index_thinghttps_on_api_key"
  add_index "thinghttps", ["user_id"], name: "index_thinghttps_on_user_id"

  create_table "timecontrols", force: true do |t|
    t.integer  "user_id"
    t.integer  "schedulable_id"
    t.string   "schedulable_type",  limit: 50
    t.string   "frequency",         limit: 20
    t.integer  "day",               limit: 1
    t.integer  "hour",              limit: 1
    t.integer  "minute",            limit: 1
    t.integer  "parent_id"
    t.datetime "last_event_at"
    t.text     "last_response"
    t.string   "name"
    t.datetime "run_at"
    t.integer  "fuzzy_seconds",                default: 0
    t.string   "schedulable_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timecontrols", ["frequency", "minute", "hour", "day"], name: "index_timecontrols_on_frequency_and_minute_and_hour_and_day"
  add_index "timecontrols", ["parent_id"], name: "index_timecontrols_on_parent_id"
  add_index "timecontrols", ["run_at"], name: "index_timecontrols_on_run_at"
  add_index "timecontrols", ["schedulable_id", "schedulable_type"], name: "index_timecontrols_on_schedulable_id_and_schedulable_type"
  add_index "timecontrols", ["user_id"], name: "index_timecontrols_on_user_id"

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

  create_table "watchings", force: true do |t|
    t.integer  "user_id"
    t.integer  "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "watchings", ["user_id", "channel_id"], name: "index_watchings_on_user_id_and_channel_id"

  create_table "windows", force: true do |t|
    t.integer  "channel_id"
    t.integer  "position"
    t.text     "html"
    t.integer  "col"
    t.string   "title"
    t.string   "window_type"
    t.string   "name"
    t.boolean  "private_flag", default: false
    t.boolean  "show_flag",    default: true
    t.integer  "content_id"
    t.text     "options"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "windows", ["channel_id"], name: "index_windows_on_channel_id"
  add_index "windows", ["window_type", "content_id"], name: "index_windows_on_window_type_and_content_id"

end
