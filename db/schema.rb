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

ActiveRecord::Schema[7.0].define(version: 2022_09_07_235740) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "body_entries", force: :cascade do |t|
    t.float "height"
    t.float "weight"
    t.float "fat_mass"
    t.float "muscle_mass"
    t.text "note"
    t.datetime "timestamp"
    t.bigint "diary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_body_entries_on_diary_id"
  end

  create_table "diaries", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_diaries_on_user_id"
  end

  create_table "diary_shares", force: :cascade do |t|
    t.integer "permission"
    t.bigint "diary_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_diary_shares_on_diary_id"
    t.index ["user_id"], name: "index_diary_shares_on_user_id"
  end

  create_table "exercise_entries", force: :cascade do |t|
    t.boolean "complete"
    t.text "note"
    t.datetime "timestamp"
    t.bigint "diary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_exercise_entries_on_diary_id"
  end

  create_table "food_complexes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "template"
    t.boolean "verified"
    t.boolean "public"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_food_complexes_on_name", unique: true
    t.index ["user_id"], name: "index_food_complexes_on_user_id"
  end

  create_table "food_simples", force: :cascade do |t|
    t.string "name"
    t.float "calories"
    t.float "fats"
    t.float "carbs"
    t.float "proteins"
    t.boolean "is_drink"
    t.float "amount"
    t.boolean "verified"
    t.boolean "public"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_food_simples_on_name", unique: true
    t.index ["user_id"], name: "index_food_simples_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.boolean "active"
    t.float "calories"
    t.float "fats"
    t.float "carbs"
    t.float "proteins"
    t.string "frequency"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "intake_entries", force: :cascade do |t|
    t.boolean "consumed"
    t.text "note"
    t.datetime "timestamp"
    t.bigint "diary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_intake_entries_on_diary_id"
  end

  create_table "note_entries", force: :cascade do |t|
    t.text "note"
    t.datetime "timestamp"
    t.bigint "diary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_note_entries_on_diary_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.string "firstname"
    t.string "lastname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "body_entries", "diaries"
  add_foreign_key "diaries", "users"
  add_foreign_key "diary_shares", "diaries"
  add_foreign_key "diary_shares", "users"
  add_foreign_key "exercise_entries", "diaries"
  add_foreign_key "food_complexes", "users"
  add_foreign_key "food_simples", "users"
  add_foreign_key "goals", "users"
  add_foreign_key "intake_entries", "diaries"
  add_foreign_key "note_entries", "diaries"
end
