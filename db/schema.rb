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

ActiveRecord::Schema[7.0].define(version: 0) do
  create_table "active_storage_attachments", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bookings", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "organization_id", unsigned: true
    t.integer "user_id", unsigned: true
    t.integer "server_id", unsigned: true
    t.datetime "start_at", precision: nil
    t.integer "duration"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["server_id"], name: "fk_bookings_servers"
    t.index ["user_id"], name: "fk_bookings_users"
  end

  create_table "buildings", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
  end

  create_table "categories", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "number", limit: 2
  end

  create_table "documents", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false, collation: "utf8_general_ci"
    t.integer "main_agreement_id", unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["main_agreement_id"], name: "fk_document_main_agreement"
  end

  create_table "good_requests", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
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
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["category_id"], name: "fk_good_requests_categories"
    t.index ["main_agreement_id"], name: "fk_good_requests_agreements"
    t.index ["user_id"], name: "fk_good_requests_holders"
  end

  create_table "goods", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "organization_id", unsigned: true
    t.integer "category_id", unsigned: true
    t.integer "location_id", unsigned: true
    t.integer "inv_number", unsigned: true
    t.string "sn", limit: 200
    t.integer "user_id", unsigned: true
    t.string "name"
    t.text "description"
    t.text "unibo_description"
    t.text "unibo_description_sub"
    t.text "admin_notes"
    t.integer "build_year"
    t.float "price"
    t.integer "load_number"
    t.date "load_date"
    t.integer "unibo_number", unsigned: true
    t.string "old_org"
    t.integer "old_inv_number", unsigned: true
    t.datetime "confirmed", precision: nil
    t.integer "confirmed_by", unsigned: true
    t.datetime "unconfirmed", precision: nil
    t.text "unconfirmed_text"
    t.boolean "to_unload"
    t.text "to_unload_status"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["category_id"], name: "fk_goods_categories"
    t.index ["location_id"], name: "fk_goods_locations"
    t.index ["organization_id"], name: "fk_goods_organizations"
    t.index ["user_id"], name: "fk_goods_users"
  end

  create_table "locations", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "organization_id", unsigned: true
    t.integer "building_id", unsigned: true
    t.string "name"
    t.index ["building_id"], name: "fk_locations_buildings"
    t.index ["organization_id"], name: "fk_locations_organizations"
  end

  create_table "main_agreements", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "organization_id", unsigned: true
    t.integer "category_id", unsigned: true
    t.string "title"
    t.string "name"
    t.string "code"
    t.string "vendor_and_model"
    t.text "description"
    t.integer "price"
    t.text "notes"
    t.string "external_link"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["category_id"], name: "fk_main_agreements_categories"
    t.index ["organization_id"], name: "fk_main_agreements_organizations"
  end

  create_table "organizations", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.string "description"
  end

  create_table "permissions", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "user_id", null: false, unsigned: true
    t.integer "organization_id", null: false, unsigned: true
    t.string "network", limit: 20
    t.integer "authlevel"
    t.index ["organization_id"], name: "fk_organization_authorization"
    t.index ["user_id"], name: "fk_user_authorization"
  end

  create_table "servers", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "organization_id", unsigned: true
    t.string "name"
    t.string "url"
    t.text "hardware"
    t.text "software"
    t.string "api_key"
    t.index ["organization_id"], name: "fk_servers_organizations"
  end

  create_table "users", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "organization_id", unsigned: true
    t.string "upn", null: false
    t.string "name"
    t.string "surname"
    t.string "email"
    t.datetime "updated_at", precision: nil
    t.index ["organization_id"], name: "fk_users_organizations"
    t.index ["upn"], name: "index_upn_on_users", length: 191
  end

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
  add_foreign_key "main_agreements", "organizations", name: "fk_main_agreements_organizations"
  add_foreign_key "permissions", "organizations", name: "fk_organization_authorization"
  add_foreign_key "permissions", "users", name: "fk_user_authorization"
  add_foreign_key "servers", "organizations", name: "fk_servers_organizations", on_delete: :cascade
  add_foreign_key "users", "organizations", name: "fk_users_organizations", on_delete: :cascade
end
