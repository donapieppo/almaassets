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

  create_table "buildings", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
  end

  create_table "categories", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "number", limit: 2
  end

  create_table "good_requests", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "user_id", unsigned: true
    t.integer "category_id", unsigned: true
    t.string "name"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id"], name: "fk_good_requests_categories"
    t.index ["user_id"], name: "fk_good_requests_users"
  end

  create_table "goods", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "category_id", unsigned: true
    t.integer "location_id", unsigned: true
    t.integer "inv_number", unsigned: true
    t.integer "user_id", unsigned: true
    t.string "name"
    t.text "description"
    t.text "unibo_description"
    t.integer "build_year"
    t.float "price"
    t.integer "load_number"
    t.date "load_date"
    t.text "user_justification"
    t.integer "unibo_number", unsigned: true
    t.string "old_org"
    t.integer "old_inv_number", unsigned: true
    t.boolean "confirmed"
    t.boolean "to_unload"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id"], name: "fk_goods_categories"
    t.index ["location_id"], name: "fk_goods_locations"
    t.index ["user_id"], name: "fk_goods_users"
  end

  create_table "locations", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "building_id", unsigned: true
    t.string "name"
    t.index ["building_id"], name: "fk_locations_buildings"
  end

  create_table "organizations", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
  end

  create_table "users", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "organization_id", unsigned: true
    t.string "upn", null: false
    t.string "name"
    t.string "surname"
    t.string "email"
    t.datetime "updated_at"
    t.index ["organization_id"], name: "fk_users_organizations"
    t.index ["upn"], name: "index_upn_on_users", length: 191
  end

  add_foreign_key "good_requests", "categories", name: "fk_good_requests_categories", on_delete: :cascade
  add_foreign_key "good_requests", "users", name: "fk_good_requests_users", on_delete: :cascade
  add_foreign_key "goods", "categories", name: "fk_goods_categories", on_delete: :cascade
  add_foreign_key "goods", "locations", name: "fk_goods_locations", on_delete: :cascade
  add_foreign_key "goods", "users", name: "fk_goods_users", on_delete: :cascade
  add_foreign_key "locations", "buildings", name: "fk_locations_buildings", on_delete: :cascade
  add_foreign_key "users", "organizations", name: "fk_users_organizations", on_delete: :cascade
end
