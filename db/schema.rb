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

ActiveRecord::Schema.define(version: 2020_03_02_233704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "category_followings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_followings_on_category_id"
    t.index ["user_id"], name: "index_category_followings_on_user_id"
  end

  create_table "collection_followings", force: :cascade do |t|
    t.bigint "collection_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_collection_followings_on_collection_id"
    t.index ["user_id"], name: "index_collection_followings_on_user_id"
  end

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "collects", force: :cascade do |t|
    t.bigint "collection_id"
    t.bigint "meme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_collects_on_collection_id"
    t.index ["meme_id"], name: "index_collects_on_meme_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id"
    t.bigint "meme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meme_id"], name: "index_comments_on_meme_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "dank_ranks", force: :cascade do |t|
    t.integer "engagement"
    t.integer "collection"
    t.integer "creation"
    t.integer "total_score"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_dank_ranks_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "meme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meme_id"], name: "index_likes_on_meme_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "memes", force: :cascade do |t|
    t.string "title"
    t.string "image_url"
    t.bigint "user_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_memes_on_category_id"
    t.index ["user_id"], name: "index_memes_on_user_id"
  end

  create_table "rarities", force: :cascade do |t|
    t.integer "comments"
    t.integer "likes"
    t.integer "shares"
    t.integer "collects"
    t.integer "total_score"
    t.bigint "meme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meme_id"], name: "index_rarities_on_meme_id"
  end

  create_table "user_followings", force: :cascade do |t|
    t.bigint "follower_id"
    t.bigint "followee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followee_id"], name: "index_user_followings_on_followee_id"
    t.index ["follower_id"], name: "index_user_followings_on_follower_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "categories", "users"
  add_foreign_key "category_followings", "categories"
  add_foreign_key "category_followings", "users"
  add_foreign_key "collection_followings", "collections"
  add_foreign_key "collection_followings", "users"
  add_foreign_key "collections", "users"
  add_foreign_key "collects", "collections"
  add_foreign_key "collects", "memes"
  add_foreign_key "comments", "memes"
  add_foreign_key "comments", "users"
  add_foreign_key "dank_ranks", "users"
  add_foreign_key "likes", "memes"
  add_foreign_key "likes", "users"
  add_foreign_key "memes", "categories"
  add_foreign_key "memes", "users"
  add_foreign_key "rarities", "memes"
  add_foreign_key "user_followings", "users", column: "followee_id"
  add_foreign_key "user_followings", "users", column: "follower_id"
end
