# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_09_120211) do

  create_table "bookmarks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "favorite_id", null: false
    t.bigint "user_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["favorite_id"], name: "index_bookmarks_on_favorite_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "favorite_data", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "favorite_id", null: false
    t.string "title", null: false
    t.string "image_path"
    t.integer "star", null: false
    t.bigint "user_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["favorite_id"], name: "index_favorite_data_on_favorite_id"
    t.index ["user_id"], name: "index_favorite_data_on_user_id"
  end

  create_table "favorite_items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "favorite_id", null: false
    t.string "name", null: false
    t.integer "type", null: false
    t.integer "order", null: false
    t.text "select_options"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["favorite_id"], name: "index_favorite_items_on_favorite_id"
  end

  create_table "favorite_values", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "favorite_data_id", null: false
    t.bigint "favorite_item_id", null: false
    t.text "value", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["favorite_data_id"], name: "index_favorite_values_on_favorite_data_id"
    t.index ["favorite_item_id"], name: "index_favorite_values_on_favorite_item_id"
  end

  create_table "favorites", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "theme", null: false
    t.string "image_path"
    t.bigint "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_favorites_on_deleted_at"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "likes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "favorite_data_id", null: false
    t.bigint "user_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["favorite_data_id"], name: "index_likes_on_favorite_data_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "photo_path", default: "/uploads/user/photo_path/default_user.jpg"
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "remember_digest"
    t.datetime "deleted_at"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "bookmarks", "favorites"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "favorite_data", "favorites"
  add_foreign_key "favorite_data", "users"
  add_foreign_key "favorite_items", "favorites"
  add_foreign_key "favorite_values", "favorite_data", column: "favorite_data_id"
  add_foreign_key "favorite_values", "favorite_items"
  add_foreign_key "favorites", "users"
  add_foreign_key "likes", "favorite_data", column: "favorite_data_id"
  add_foreign_key "likes", "users"
end
