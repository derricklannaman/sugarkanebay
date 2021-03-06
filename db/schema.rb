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

ActiveRecord::Schema.define(version: 20170414183948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "owner_name"
    t.decimal  "price"
    t.decimal  "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carts_on_user_id", using: :btree
  end

  create_table "destinations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "index_image"
    t.string   "food_discovery_thumbnail"
    t.string   "poi_discovery_thumbnail"
    t.string   "music_discovery_thumbnail"
    t.string   "geography_discovery_thumbnail"
    t.string   "culture_discovery_thumbnail"
    t.string   "art_discovery_thumbnail"
    t.string   "political_discovery_thumbnail"
    t.string   "shop_discovery_thumbnail"
  end

  create_table "discovery_contents", force: :cascade do |t|
    t.integer  "destination_id"
    t.string   "title"
    t.string   "thumbnail"
    t.text     "description"
    t.string   "immersive_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["destination_id"], name: "index_discovery_contents_on_destination_id", using: :btree
  end

  create_table "inventories", force: :cascade do |t|
    t.integer  "order_item_id"
    t.integer  "minimum_level"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "meal_id",                          null: false
    t.integer  "current_quantity",     default: 0
    t.integer  "recommended_quantity", default: 0
    t.string   "name"
    t.index ["order_item_id"], name: "index_inventories_on_order_item_id", using: :btree
  end

  create_table "meal_inventories", force: :cascade do |t|
    t.integer  "meal_id"
    t.integer  "inventory_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["inventory_id"], name: "index_meal_inventories_on_inventory_id", using: :btree
    t.index ["meal_id"], name: "index_meal_inventories_on_meal_id", using: :btree
  end

  create_table "meals", force: :cascade do |t|
    t.string   "name"
    t.integer  "destination_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.decimal  "cost",                precision: 5, scale: 2
    t.decimal  "price",               precision: 5, scale: 2
    t.integer  "user_id"
    t.string   "thumbnail_image"
    t.string   "standard_image"
    t.text     "description_details"
    t.index ["destination_id"], name: "index_meals_on_destination_id", using: :btree
    t.index ["user_id"], name: "index_meals_on_user_id", using: :btree
  end

  create_table "order_histories", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "total"
    t.integer  "quantity"
    t.string   "guid"
    t.date     "order_shipped_date"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["user_id"], name: "index_order_histories_on_user_id", using: :btree
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "meal_id"
    t.integer  "quantity"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.decimal  "total_price", precision: 5, scale: 2
    t.index ["meal_id"], name: "index_order_items_on_meal_id", using: :btree
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
  end

  create_table "order_statuses", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_statuses_on_order_id", using: :btree
    t.index ["user_id"], name: "index_order_statuses_on_user_id", using: :btree
  end

  create_table "ordered_item_histories", force: :cascade do |t|
    t.integer  "order_history_id"
    t.integer  "meal_id"
    t.integer  "quantity"
    t.decimal  "total_price"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["order_history_id"], name: "index_ordered_item_histories_on_order_history_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "cart_id"
    t.decimal  "total"
    t.string   "order_items"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "order_status",       default: "pending-payment"
    t.integer  "quantity",           default: 0
    t.string   "guid"
    t.date     "order_shipped_date"
    t.index ["cart_id"], name: "index_orders_on_cart_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "firstname"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.text     "lastname"
    t.text     "phone"
    t.text     "country"
    t.text     "address1"
    t.text     "address2"
    t.text     "city"
    t.text     "state"
    t.text     "zip"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "carts", "users"
  add_foreign_key "discovery_contents", "destinations"
  add_foreign_key "meal_inventories", "inventories"
  add_foreign_key "meal_inventories", "meals"
  add_foreign_key "meals", "destinations"
  add_foreign_key "order_histories", "users"
  add_foreign_key "order_items", "meals"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_statuses", "orders"
  add_foreign_key "order_statuses", "users"
  add_foreign_key "ordered_item_histories", "order_histories"
  add_foreign_key "orders", "carts"
  add_foreign_key "orders", "users"
end
