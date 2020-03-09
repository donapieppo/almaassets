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

ActiveRecord::Schema.define(version: 2019_12_02_110147) do

  create_table "bookings", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "organization_id", unsigned: true
    t.integer "user_id", unsigned: true
    t.integer "server_id", unsigned: true
    t.datetime "start_at"
    t.integer "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["server_id"], name: "fk_bookings_servers"
    t.index ["user_id"], name: "fk_bookings_users"
  end

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

  create_table "documents", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false, collation: "utf8_general_ci"
    t.integer "main_agreement_id", unsigned: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["main_agreement_id"], name: "fk_document_main_agreement"
  end

  create_table "good_requests", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "organization_id", unsigned: true
    t.integer "user_id", unsigned: true
    t.integer "category_id", unsigned: true
    t.integer "main_agreement_id", unsigned: true
    t.string "name"
    t.text "description"
    t.text "teach_description"
    t.text "derogation"
    t.integer "holder_id", unsigned: true
    t.integer "max_price"
    t.string "aasm_state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id"], name: "fk_good_requests_categories"
    t.index ["main_agreement_id"], name: "fk_good_requests_agreements"
    t.index ["user_id"], name: "fk_good_requests_holders"
  end

  create_table "goods", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "organization_id", unsigned: true
    t.integer "category_id", unsigned: true
    t.integer "location_id", unsigned: true
    t.integer "inv_number", unsigned: true
    t.string "sn", limit: 200
    t.integer "user_id", unsigned: true
    t.string "name"
    t.text "description"
    t.text "unibo_description"
    t.text "admin_notes"
    t.integer "build_year"
    t.float "price"
    t.integer "load_number"
    t.date "load_date"
    t.integer "unibo_number", unsigned: true
    t.string "old_org"
    t.integer "old_inv_number", unsigned: true
    t.datetime "confirmed"
    t.integer "confirmed_by", unsigned: true
    t.datetime "unconfirmed"
    t.text "unconfirmed_text"
    t.boolean "to_unload"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id"], name: "fk_goods_categories"
    t.index ["location_id"], name: "fk_goods_locations"
    t.index ["organization_id"], name: "fk_goods_organizations"
    t.index ["user_id"], name: "fk_goods_users"
  end

  create_table "locations", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "organization_id", unsigned: true
    t.integer "building_id", unsigned: true
    t.string "name"
    t.index ["building_id"], name: "fk_locations_buildings"
    t.index ["organization_id"], name: "fk_locations_organizations"
  end

  create_table "main_agreements", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "category_id", unsigned: true
    t.string "title"
    t.string "name"
    t.string "code"
    t.string "vendor_and_model"
    t.text "description"
    t.integer "price"
    t.text "notes"
    t.string "external_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id"], name: "fk_main_agreements_categories"
  end

  create_table "organizations", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.string "description"
  end

  create_table "permissions", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "user_id", null: false, unsigned: true
    t.integer "organization_id", null: false, unsigned: true
    t.integer "authlevel"
    t.index ["organization_id"], name: "fk_organization_authorization"
    t.index ["user_id"], name: "fk_user_authorization"
  end

  create_table "servers", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "organization_id", unsigned: true
    t.string "name"
    t.string "url"
    t.text "hardware"
    t.text "software"
    t.string "api_key"
    t.index ["organization_id"], name: "fk_servers_organizations"
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

  add_foreign_key "bookings", "servers", name: "fk_bookings_servers", on_delete: :cascade
  add_foreign_key "bookings", "users", name: "fk_bookings_users", on_delete: :cascade
  add_foreign_key "documents", "main_agreements", name: "fk_document_main_agreement"
  add_foreign_key "good_requests", "categories", name: "fk_good_requests_categories", on_delete: :cascade
  add_foreign_key "good_requests", "main_agreements", name: "fk_good_requests_agreements", on_delete: :cascade
  add_foreign_key "good_requests", "users", name: "fk_good_requests_holders", on_delete: :cascade
  add_foreign_key "good_requests", "users", name: "fk_good_requests_users", on_delete: :cascade
  add_foreign_key "goods", "categories", name: "fk_goods_categories", on_delete: :cascade
  add_foreign_key "goods", "locations", name: "fk_goods_locations", on_delete: :cascade
  add_foreign_key "goods", "organizations", name: "fk_goods_organizations", on_delete: :cascade
  add_foreign_key "goods", "users", name: "fk_goods_users", on_delete: :cascade
  add_foreign_key "locations", "buildings", name: "fk_locations_buildings", on_delete: :cascade
  add_foreign_key "locations", "organizations", name: "fk_locations_organizations"
  add_foreign_key "main_agreements", "categories", name: "fk_main_agreements_categories", on_delete: :cascade
  add_foreign_key "permissions", "organizations", name: "fk_organization_authorization"
  add_foreign_key "permissions", "users", name: "fk_user_authorization"
  add_foreign_key "servers", "organizations", name: "fk_servers_organizations", on_delete: :cascade
  add_foreign_key "users", "organizations", name: "fk_users_organizations", on_delete: :cascade
end
