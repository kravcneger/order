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

ActiveRecord::Schema[7.0].define(version: 2023_09_24_203017) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "compositions", id: false, force: :cascade do |t|
    t.bigint "dish_id", null: false
    t.bigint "ingredient_id", null: false
    t.index ["dish_id", "ingredient_id"], name: "index_compositions_on_dish_id_and_ingredient_id", unique: true
    t.index ["dish_id"], name: "index_compositions_on_dish_id"
    t.index ["ingredient_id"], name: "index_compositions_on_ingredient_id"
  end

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_dishes_on_name", unique: true
  end

  create_table "exclusions", id: false, force: :cascade do |t|
    t.bigint "subscriber_id", null: false
    t.bigint "ingredient_id", null: false
    t.index ["ingredient_id"], name: "index_exclusions_on_ingredient_id"
    t.index ["subscriber_id", "ingredient_id"], name: "index_exclusions_on_subscriber_id_and_ingredient_id", unique: true
    t.index ["subscriber_id"], name: "index_exclusions_on_subscriber_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_ingredients_on_name", unique: true
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_subscribers_on_email", unique: true
  end

  add_foreign_key "compositions", "dishes"
  add_foreign_key "compositions", "ingredients"
  add_foreign_key "exclusions", "ingredients"
  add_foreign_key "exclusions", "subscribers"
end
