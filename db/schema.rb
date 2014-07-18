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

ActiveRecord::Schema.define(version: 20140718095745) do

  create_table "bill_items", force: true do |t|
    t.integer  "bill_id"
    t.string   "name"
    t.decimal  "amount",     precision: 7, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bill_items", ["bill_id"], name: "index_bill_items_on_bill_id", using: :btree

  create_table "bills", force: true do |t|
    t.integer  "center_id"
    t.integer  "student_id"
    t.string   "full_number"
    t.integer  "number"
    t.integer  "month"
    t.integer  "year"
    t.decimal  "total_amount", precision: 7, scale: 2
    t.boolean  "is_overdue",                           default: false
    t.boolean  "is_paid",                              default: false
    t.datetime "overdue_at"
    t.boolean  "is_active",                            default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bills", ["center_id"], name: "index_bills_on_center_id", using: :btree
  add_index "bills", ["student_id"], name: "index_bills_on_student_id", using: :btree

  create_table "branches", force: true do |t|
    t.integer  "center_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "branches", ["center_id"], name: "index_branches_on_center_id", using: :btree

  create_table "centers", force: true do |t|
    t.string   "name"
    t.decimal  "credit_balance", precision: 8, scale: 4, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "centers", ["name"], name: "index_centers_on_name", unique: true, using: :btree

  create_table "combination_fees", force: true do |t|
    t.integer  "center_id"
    t.string   "name"
    t.decimal  "price",      precision: 7, scale: 2
    t.boolean  "is_active",                          default: true
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

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "calling_code"
    t.decimal  "sms_rate",     precision: 6, scale: 4
    t.boolean  "is_active",                            default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "credit_usages", force: true do |t|
    t.integer  "message_id"
    t.integer  "credit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "credit_usages", ["credit_id"], name: "index_credit_usages_on_credit_id", using: :btree
  add_index "credit_usages", ["message_id"], name: "index_credit_usages_on_message_id", using: :btree

  create_table "credits", force: true do |t|
    t.integer  "center_id"
    t.decimal  "amount",     precision: 8, scale: 4, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "credits", ["center_id"], name: "index_credits_on_center_id", using: :btree

  create_table "enroll_subjects", force: true do |t|
    t.integer  "enroll_id"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enroll_subjects", ["enroll_id"], name: "index_enroll_subjects_on_enroll_id", using: :btree
  add_index "enroll_subjects", ["subject_id"], name: "index_enroll_subjects_on_subject_id", using: :btree

  create_table "enrolls", force: true do |t|
    t.integer  "student_id"
    t.integer  "enrollable_id"
    t.string   "enrollable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enrolls", ["enrollable_id", "enrollable_type"], name: "index_enrolls_on_enrollable_id_and_enrollable_type", using: :btree
  add_index "enrolls", ["student_id"], name: "index_enrolls_on_student_id", using: :btree

  create_table "groups", force: true do |t|
    t.integer  "center_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["center_id"], name: "index_groups_on_center_id", using: :btree

  create_table "invitations", force: true do |t|
    t.integer  "center_id"
    t.string   "email"
    t.string   "key"
    t.boolean  "is_used",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["center_id"], name: "index_invitations_on_center_id", using: :btree
  add_index "invitations", ["key"], name: "index_invitations_on_key", unique: true, using: :btree

  create_table "messages", force: true do |t|
    t.integer  "center_id"
    t.integer  "student_id"
    t.string   "sid"
    t.string   "phone_code"
    t.string   "phone_number"
    t.string   "content"
    t.string   "processed_content"
    t.string   "sent_content"
    t.string   "failed_messages"
    t.decimal  "price",             precision: 6, scale: 4
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["center_id"], name: "index_messages_on_center_id", using: :btree
  add_index "messages", ["student_id"], name: "index_messages_on_student_id", using: :btree

  create_table "options", force: true do |t|
    t.integer  "center_id"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "options", ["center_id"], name: "index_options_on_center_id", using: :btree

  create_table "payments", force: true do |t|
    t.integer  "user_id"
    t.integer  "bill_id"
    t.decimal  "amount",     precision: 7, scale: 2
    t.datetime "paid_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["bill_id"], name: "index_payments_on_bill_id", using: :btree
  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree

  create_table "quantity_fees", force: true do |t|
    t.integer  "center_id"
    t.integer  "subject_id"
    t.string   "name"
    t.decimal  "price",      precision: 7, scale: 2
    t.boolean  "is_active",                          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quantity_fees", ["center_id"], name: "index_quantity_fees_on_center_id", using: :btree
  add_index "quantity_fees", ["subject_id"], name: "index_quantity_fees_on_subject_id", using: :btree

  create_table "students", force: true do |t|
    t.integer  "center_id"
    t.integer  "branch_id"
    t.integer  "group_id"
    t.string   "ic"
    t.string   "public_key"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "email"
    t.string   "phone_code"
    t.string   "phone_number"
    t.string   "backup_phone_code"
    t.string   "backup_phone_number"
    t.string   "school_name"
    t.string   "note1"
    t.string   "note2"
    t.string   "note3"
    t.boolean  "is_active",           default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["branch_id"], name: "index_students_on_branch_id", using: :btree
  add_index "students", ["center_id"], name: "index_students_on_center_id", using: :btree
  add_index "students", ["group_id"], name: "index_students_on_group_id", using: :btree
  add_index "students", ["public_key"], name: "index_students_on_public_key", unique: true, using: :btree

  create_table "subjects", force: true do |t|
    t.integer  "center_id"
    t.string   "name"
    t.boolean  "is_active",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["center_id"], name: "index_subjects_on_center_id", using: :btree

  create_table "subscriptions", force: true do |t|
    t.integer  "center_id"
    t.integer  "quantity"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["center_id"], name: "index_subscriptions_on_center_id", using: :btree

  create_table "transactions", force: true do |t|
    t.integer  "transactable_id"
    t.string   "transactable_type"
    t.string   "reference_number"
    t.string   "merchant"
    t.decimal  "value",             precision: 10, scale: 0
    t.datetime "paid_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "center_id"
    t.string   "email",                  default: "",   null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "access_level",           default: 50
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "is_active",              default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["center_id"], name: "index_users_on_center_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
