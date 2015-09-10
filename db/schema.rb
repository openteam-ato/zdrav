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

ActiveRecord::Schema.define(version: 20150910032617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "coupons", force: :cascade do |t|
    t.string   "number"
    t.string   "patient_code"
    t.datetime "issued_on"
    t.datetime "closing_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doctors", force: :cascade do |t|
    t.text     "name"
    t.text     "post"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.text     "photo_url"
    t.text     "photo_meta"
    t.string   "slug"
  end

  add_index "doctors", ["slug"], name: "index_doctors_on_slug", unique: true, using: :btree

  create_table "evaluation_registries", force: :cascade do |t|
    t.text     "title"
    t.integer  "question_1_1"
    t.integer  "question_1_2"
    t.integer  "question_1_3"
    t.integer  "question_1_4"
    t.integer  "question_1_5"
    t.integer  "question_1_6"
    t.integer  "question_1_7"
    t.integer  "question_1_8"
    t.integer  "question_1_9"
    t.integer  "question_1_10"
    t.integer  "question_1_11"
    t.integer  "question_2_1"
    t.integer  "question_2_2"
    t.integer  "question_2_3"
    t.integer  "question_2_4"
    t.integer  "question_2_5"
    t.integer  "question_2_6"
    t.integer  "question_2_7"
    t.integer  "question_2_8"
    t.integer  "question_2_9"
    t.integer  "question_3_1"
    t.integer  "question_3_2"
    t.integer  "question_3_3"
    t.integer  "question_3_4"
    t.integer  "question_3_5"
    t.integer  "question_3_6"
    t.integer  "question_4_1"
    t.integer  "question_4_2"
    t.integer  "question_4_3"
    t.integer  "question_5_1"
    t.integer  "question_5_2"
    t.text     "proposal"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "ip"
    t.text     "user_agent"
    t.text     "username"
  end

  create_table "evaluation_registry_attachments", force: :cascade do |t|
    t.integer  "evaluation_registry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.text     "attachment_url"
    t.text     "attachment_meta"
  end

  add_index "evaluation_registry_attachments", ["evaluation_registry_id"], name: "index_evaluation_registry_attachments_on_evaluation_registry_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", unique: true, using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "permissions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "context_id"
    t.string   "context_type"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permissions", ["user_id", "role", "context_id", "context_type"], name: "by_user_and_role_and_context", unique: true, using: :btree

  create_table "spatial_ref_sys", primary_key: "srid", force: :cascade do |t|
    t.string  "auth_name", limit: 256
    t.integer "auth_srid"
    t.string  "srtext",    limit: 2048
    t.string  "proj4text", limit: 2048
  end

  create_table "thanks", force: :cascade do |t|
    t.string   "fullname"
    t.string   "email"
    t.text     "message"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.string   "key"
    t.text     "ip"
    t.text     "user_agent"
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.text     "name"
    t.text     "email"
    t.text     "raw_info"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

end
