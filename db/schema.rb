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

ActiveRecord::Schema[7.0].define(version: 2023_09_19_091727) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.text "summary"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.integer "commentable_id"
    t.string "commentable_type"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "kpi_upvotes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "kpi_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kpi_id"], name: "index_kpi_upvotes_on_kpi_id"
    t.index ["user_id", "kpi_id"], name: "index_kpi_upvotes_on_user_id_and_kpi_id", unique: true
    t.index ["user_id"], name: "index_kpi_upvotes_on_user_id"
  end

  create_table "kpis", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id", null: false
    t.string "unit"
    t.text "description"
    t.text "formula"
    t.text "example"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "subcategory_id"
    t.integer "upvote_count"
    t.index ["category_id"], name: "index_kpis_on_category_id"
    t.index ["slug"], name: "index_kpis_on_slug", unique: true
    t.index ["subcategory_id"], name: "index_kpis_on_subcategory_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "email"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_notifications_on_category_id"
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["category_id"], name: "index_subcategories_on_category_id"
    t.index ["slug", "category_id"], name: "index_subcategories_on_slug_and_category_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "provider"
    t.string "uid"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "users"
  add_foreign_key "kpi_upvotes", "kpis"
  add_foreign_key "kpi_upvotes", "users"
  add_foreign_key "kpis", "categories"
  add_foreign_key "notifications", "categories"
  add_foreign_key "subcategories", "categories"
end
