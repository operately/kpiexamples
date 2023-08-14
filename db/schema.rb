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

ActiveRecord::Schema[7.0].define(version: 2023_08_14_084707) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
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
    t.index ["category_id"], name: "index_kpis_on_category_id"
    t.index ["slug"], name: "index_kpis_on_slug", unique: true
    t.index ["subcategory_id"], name: "index_kpis_on_subcategory_id"
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

  add_foreign_key "kpis", "categories"
  add_foreign_key "subcategories", "categories"
end
