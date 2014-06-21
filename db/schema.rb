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

ActiveRecord::Schema.define(version: 20140618140003) do

  create_table "users", force: true do |t|
    t.string   "password_digest"
    t.string   "lname",           limit: 50
    t.string   "fname",           limit: 50
    t.string   "email",           limit: 100
    t.integer  "gender"
    t.integer  "enrol"
    t.string   "city",            limit: 50
    t.integer  "code"
    t.string   "country",         limit: 30
    t.string   "region",          limit: 40
    t.string   "phone",           limit: 14
    t.string   "fax",             limit: 14
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
