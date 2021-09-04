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

ActiveRecord::Schema.define(version: 2021_05_24_182609) do

  create_table "boards", force: :cascade do |t|
    t.integer "counter_turn", default: 0
    t.integer "turn_player", default: 1
    t.string "result"
    t.integer "player_one_id"
    t.integer "player_two_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_one_id"], name: "index_boards_on_player_one_id"
    t.index ["player_two_id"], name: "index_boards_on_player_two_id"
  end

  create_table "cells", force: :cascade do |t|
    t.integer "turn"
    t.integer "position"
    t.boolean "marked", default: false
    t.integer "user_id"
    t.integer "board_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["board_id"], name: "index_cells_on_board_id"
    t.index ["user_id"], name: "index_cells_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "nickname"
    t.string "token"
    t.boolean "connected", default: false
    t.boolean "playing", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "boards", "users", column: "player_one_id"
  add_foreign_key "boards", "users", column: "player_two_id"
end
