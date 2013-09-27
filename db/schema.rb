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

ActiveRecord::Schema.define(version: 20130927155002) do

  create_table "centers", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "centers", ["name"], name: "index_centers_on_name", unique: true, using: :btree
  add_index "centers", ["user_id"], name: "index_centers_on_user_id", using: :btree

  create_table "combination_fees", force: true do |t|
    t.integer  "center_id"
    t.string   "name"
    t.integer  "min_subjects"
    t.integer  "max_subjects"
    t.decimal  "price",        precision: 6, scale: 2
    t.boolean  "is_active",                            default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "combination_fees", ["center_id"], name: "index_combination_fees_on_center_id", using: :btree

  create_table "combination_item_fees", force: true do |t|
    t.integer  "combination_fee_id"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "combination_item_fees", ["combination_fee_id"], name: "index_combination_item_fees_on_combination_fee_id", using: :btree
  add_index "combination_item_fees", ["subject_id"], name: "index_combination_item_fees_on_subject_id", using: :btree

  create_table "enrolls", force: true do |t|
    t.integer  "student_id"
    t.integer  "enrollable_id"
    t.string   "enrollable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enrolls", ["enrollable_id", "enrollable_type"], name: "index_enrolls_on_enrollable_id_and_enrollable_type", using: :btree
  add_index "enrolls", ["student_id"], name: "index_enrolls_on_student_id", using: :btree

  create_table "quantity_fees", force: true do |t|
    t.integer  "center_id"
    t.integer  "subject_id"
    t.decimal  "price",      precision: 6, scale: 2
    t.boolean  "is_active",                          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quantity_fees", ["center_id"], name: "index_quantity_fees_on_center_id", using: :btree
  add_index "quantity_fees", ["subject_id"], name: "index_quantity_fees_on_subject_id", using: :btree

  create_table "students", force: true do |t|
    t.integer  "center_id"
    t.string   "ic"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "email"
    t.string   "phone"
    t.string   "school_name"
    t.boolean  "is_active",   default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["center_id"], name: "index_students_on_center_id", using: :btree

  create_table "subjects", force: true do |t|
    t.integer  "center_id"
    t.string   "name"
    t.boolean  "is_active",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["center_id"], name: "index_subjects_on_center_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "is_admin",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
