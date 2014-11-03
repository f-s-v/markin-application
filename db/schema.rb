# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141103134919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "content_blocks", force: true do |t|
    t.integer  "page_id"
    t.string   "page_type"
    t.json     "content"
    t.integer  "width"
    t.string   "block_style"
    t.boolean  "padding",              default: false
    t.string   "font_style"
    t.string   "border_style",         default: "white"
    t.string   "background_style"
    t.string   "image_style"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_number"
    t.integer  "height"
    t.boolean  "stretch_height",       default: false
    t.string   "image"
    t.text     "embed_code"
    t.string   "link"
    t.boolean  "open_link_in_new_tab", default: false
  end

  add_index "content_blocks", ["page_id", "page_type"], name: "index_content_blocks_on_page_id_and_page_type", using: :btree

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries_order_delivery_zones", id: false, force: true do |t|
    t.integer  "country_id"
    t.integer  "delivery_zone_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries_order_delivery_zones", ["country_id"], name: "index_countries_order_delivery_zones_on_country_id", using: :btree
  add_index "countries_order_delivery_zones", ["delivery_zone_id"], name: "index_countries_order_delivery_zones_on_delivery_zone_id", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["receiver_id", "receiver_type"], name: "index_messages_on_receiver_id_and_receiver_type", using: :btree

  create_table "order_delivery_zones", force: true do |t|
    t.decimal  "delivery_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "order_items", force: true do |t|
    t.integer  "amount"
    t.integer  "order_id"
    t.decimal  "price"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "size"
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id", using: :btree

  create_table "order_payments", force: true do |t|
    t.integer  "order_id"
    t.string   "payment_token"
    t.string   "payer_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.string   "payer_ip"
    t.string   "payment_transaction_id"
  end

  add_index "order_payments", ["order_id"], name: "index_order_payments_on_order_id", using: :btree
  add_index "order_payments", ["state"], name: "index_order_payments_on_state", using: :btree

  create_table "order_shipping_infos", force: true do |t|
    t.integer  "order_id"
    t.integer  "country_id"
    t.string   "shipping_address_line1"
    t.string   "shipping_address_line2"
    t.string   "shipping_city"
    t.string   "shipping_state"
    t.string   "shipping_zip"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shipping_name"
  end

  add_index "order_shipping_infos", ["country_id"], name: "index_order_shipping_infos_on_country_id", using: :btree
  add_index "order_shipping_infos", ["order_id"], name: "index_order_shipping_infos_on_order_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "public_id"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "pages", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "papers", force: true do |t|
    t.string   "public_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "poster"
    t.datetime "published_at"
  end

  create_table "product_batches", force: true do |t|
    t.string   "poster"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "public_id"
    t.boolean  "featured",   default: false
  end

  create_table "product_characteristic_options", force: true do |t|
    t.integer  "characteristic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_characteristic_options", ["characteristic_id"], name: "index_product_characteristic_options_on_characteristic_id", using: :btree

  create_table "product_characteristic_options_products", id: false, force: true do |t|
    t.integer "product_id"
    t.integer "option_id"
  end

  create_table "product_characteristics", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "batch_id"
    t.decimal  "price"
    t.string   "poster"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "public_id"
    t.boolean  "has_sizes"
  end

  add_index "products", ["batch_id"], name: "index_products_on_batch_id", using: :btree

  create_table "translations", force: true do |t|
    t.string   "locale"
    t.text     "text"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key"
  end

  add_index "translations", ["owner_id", "owner_type"], name: "index_translations_on_owner_id_and_owner_type", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
