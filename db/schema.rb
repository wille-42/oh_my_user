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

ActiveRecord::Schema.define(version: 20150719040522) do

  create_table "permissions", force: :cascade do |t|
    t.string   "resource"
    t.string   "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "role_id"
  end

  add_index "permissions", ["role_id"], name: "index_permissions_on_role_id"

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_staffs", id: false, force: :cascade do |t|
    t.integer "role_id",  null: false
    t.integer "staff_id", null: false
  end

  add_index "roles_staffs", ["role_id", "staff_id"], name: "index_roles_staffs_on_role_id_and_staff_id"
  add_index "roles_staffs", ["staff_id", "role_id"], name: "index_roles_staffs_on_staff_id_and_role_id"

  create_table "staffs", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
