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

ActiveRecord::Schema.define(version: 20171123221743) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "clan_members", force: :cascade do |t|
    t.string "race"
    t.string "nick_name"
    t.string "player_link"
    t.integer "player_level"
    t.string "player_post"
    t.string "city"
    t.string "name"
    t.date "birthday"
    t.string "department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "listings", force: :cascade do |t|
    t.string "title"
    t.string "short_content"
    t.string "full_content"
    t.bigint "user_id"
    t.integer "view_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_listings_on_user_id"
  end

  create_table "news_comments", force: :cascade do |t|
    t.bigint "listing_id"
    t.bigint "user_id"
    t.string "quote_head"
    t.string "quote_content"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_news_comments_on_listing_id"
    t.index ["user_id"], name: "index_news_comments_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "user_id"
    t.bigint "topic_id"
    t.bigint "theme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["theme_id"], name: "index_posts_on_theme_id"
    t.index ["topic_id"], name: "index_posts_on_topic_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "themes", force: :cascade do |t|
    t.string "title"
    t.bigint "group_id"
    t.integer "topics_count", default: 0
    t.json "last_post"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "post_count", default: 0
    t.index ["group_id"], name: "index_themes_on_group_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "user_id"
    t.bigint "group_id"
    t.bigint "theme_id"
    t.json "last_post"
    t.integer "posts_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_topics_on_group_id"
    t.index ["theme_id"], name: "index_topics_on_theme_id"
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "nick_name"
    t.integer "role", default: 0
    t.string "email"
    t.string "password_digest"
    t.string "gender"
    t.date "birthday"
    t.string "profile_photo"
    t.string "player_link"
    t.boolean "email_confirmation", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirm_token"
  end

  add_foreign_key "listings", "users"
  add_foreign_key "posts", "themes"
  add_foreign_key "posts", "topics"
  add_foreign_key "posts", "users"
  add_foreign_key "themes", "groups"
  add_foreign_key "topics", "groups"
  add_foreign_key "topics", "themes"
  add_foreign_key "topics", "users"
end
