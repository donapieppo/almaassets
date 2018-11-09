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

ActiveRecord::Schema.define(version: 0) do

  create_table "cathegories", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
  end

  create_table "goods", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "actual_status", limit: 9
    t.integer "cathegory_id", unsigned: true
    t.integer "user_id", unsigned: true
    t.string "name"
    t.string "description"
    t.index ["cathegory_id"], name: "fk_goods_cathegories"
    t.index ["user_id"], name: "fk_goods_users"
  end

  create_table "users", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "upn", null: false
    t.string "name"
    t.string "surname"
    t.string "email"
    t.datetime "updated_at"
    t.index ["upn"], name: "index_upn_on_users", length: 191
  end

  add_foreign_key "goods", "cathegories", name: "fk_goods_cathegories", on_delete: :cascade
  add_foreign_key "goods", "users", name: "fk_goods_users", on_delete: :cascade
end
