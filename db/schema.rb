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

ActiveRecord::Schema.define(version: 20180903041203) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coupons", force: :cascade do |t|
    t.string   "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "patient_id"
    t.string   "workflow_state"
    t.date     "issued_on"
    t.date     "created_on"
    t.integer  "medical_institution_id"
    t.date     "not_need_help_on"
    t.date     "failure_patient_on"
    t.date     "help_provided_on"
    t.date     "closed_on"
  end

  create_table "declaration_supports", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "patronymic"
    t.string   "job"
    t.boolean  "agreement"
    t.string   "email"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "state"
    t.string   "regional_institution_job"
  end

  create_table "doctors", force: :cascade do |t|
    t.text     "name"
    t.text     "post"
    t.text     "description"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.text     "photo_url"
    t.text     "photo_meta"
    t.string   "slug",               limit: 255
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
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "ip"
    t.text     "user_agent"
    t.text     "username"
  end

  create_table "evaluation_registry_attachments", force: :cascade do |t|
    t.integer  "evaluation_registry_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.text     "attachment_url"
    t.text     "attachment_meta"
  end

  add_index "evaluation_registry_attachments", ["evaluation_registry_id"], name: "index_evaluation_registry_attachments_on_evaluation_registry_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", unique: true, using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "medical_institutions", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patients", force: :cascade do |t|
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "context_id"
    t.string   "context_type", limit: 255
    t.string   "role",         limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "permissions", ["user_id", "role", "context_id", "context_type"], name: "by_user_and_role_and_context", unique: true, using: :btree

  create_table "thanks", force: :cascade do |t|
    t.string   "fullname",     limit: 255
    t.string   "email",        limit: 255
    t.text     "message"
    t.string   "state",        limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "published_at"
    t.string   "key",          limit: 255
    t.text     "ip"
    t.text     "user_agent"
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid",                limit: 255
    t.text     "name"
    t.text     "email"
    t.text     "raw_info"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip", limit: 255
    t.string   "last_sign_in_ip",    limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "video_messages", force: :cascade do |t|
    t.string   "target"
    t.string   "title"
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "aasm_state"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "question_source_file_name"
    t.string   "question_source_content_type"
    t.integer  "question_source_file_size"
    t.datetime "question_source_updated_at"
    t.text     "question_source_url"
    t.string   "question_source_fingerprint"
    t.string   "question_converted_file_name"
    t.string   "question_converted_content_type"
    t.integer  "question_converted_file_size"
    t.datetime "question_converted_updated_at"
    t.text     "question_converted_url"
    t.string   "question_converted_fingerprint"
    t.string   "answer_source_file_name"
    t.string   "answer_source_content_type"
    t.integer  "answer_source_file_size"
    t.datetime "answer_source_updated_at"
    t.text     "answer_source_url"
    t.string   "answer_source_fingerprint"
    t.string   "answer_converted_file_name"
    t.string   "answer_converted_content_type"
    t.integer  "answer_converted_file_size"
    t.datetime "answer_converted_updated_at"
    t.text     "answer_converted_url"
    t.string   "answer_converted_fingerprint"
    t.text     "delete_reason"
    t.text     "ip"
    t.text     "user_agent"
    t.string   "question_screenshot_file_name"
    t.string   "question_screenshot_content_type"
    t.integer  "question_screenshot_file_size"
    t.datetime "question_screenshot_updated_at"
    t.text     "question_screenshot_url"
    t.string   "answer_screenshot_file_name"
    t.string   "answer_screenshot_content_type"
    t.integer  "answer_screenshot_file_size"
    t.datetime "answer_screenshot_updated_at"
    t.text     "answer_screenshot_url"
    t.string   "answer_author"
    t.text     "answer_author_post"
    t.datetime "published_at"
  end

end
