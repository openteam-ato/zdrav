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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150227081728) do

  create_table "doctors", :force => true do |t|
    t.text     "name"
    t.text     "post"
    t.text     "description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.text     "photo_url"
    t.text     "photo_meta"
    t.string   "slug"
  end

  add_index "doctors", ["slug"], :name => "index_doctors_on_slug", :unique => true

  create_table "evaluation_registries", :force => true do |t|
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
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.text     "ip"
    t.text     "user_agent"
  end

  create_table "evaluation_registry_attachments", :force => true do |t|
    t.integer  "evaluation_registry_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.text     "attachment_url"
    t.text     "attachment_meta"
  end

  add_index "evaluation_registry_attachments", ["evaluation_registry_id"], :name => "index_evaluation_registry_attachments_on_evaluation_registry_id"

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "permissions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "context_id"
    t.string   "context_type"
    t.string   "role"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "permissions", ["user_id", "role", "context_id", "context_type"], :name => "by_user_and_role_and_context", :unique => true

  create_table "thanks", :force => true do |t|
    t.string   "fullname"
    t.string   "email"
    t.text     "message"
    t.string   "state"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.datetime "published_at"
    t.string   "key"
  end

  create_table "users", :force => true do |t|
    t.string   "uid"
    t.text     "name"
    t.text     "email"
    t.text     "raw_info"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "users", ["uid"], :name => "index_users_on_uid"

end
