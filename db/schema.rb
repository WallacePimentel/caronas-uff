# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2026_02_08_003835) do

  create_table "campus", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "description"
    t.string "street_adress"
    t.string "number"
    t.string "district"
    t.string "city"
    t.string "CEP"
    t.datetime "deactivation_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
  end

  create_table "carpools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "beginning_campus_id", null: false
    t.bigint "ending_campus_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["beginning_campus_id"], name: "index_carpools_on_beginning_campus_id"
    t.index ["ending_campus_id"], name: "index_carpools_on_ending_campus_id"
  end

  add_foreign_key "carpools", "campus", column: "beginning_campus_id"
  add_foreign_key "carpools", "campus", column: "ending_campus_id"
end
