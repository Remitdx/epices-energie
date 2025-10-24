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

ActiveRecord::Schema[8.0].define(version: 2025_10_23_114526) do
  create_table "dailies", force: :cascade do |t|
    t.datetime "date"
    t.integer "energy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "raw_data", force: :cascade do |t|
    t.integer "identifier"
    t.datetime "datetime"
    t.integer "energy"
    t.integer "daily_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["daily_id"], name: "index_raw_data_on_daily_id"
  end

  add_foreign_key "raw_data", "dailies"
end
