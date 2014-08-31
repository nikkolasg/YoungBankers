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

ActiveRecord::Schema.define(version: 20140831125946) do

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organizations", ["user_id"], name: "index_organizations_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "password_digest"
    t.string   "lname",           limit: 50
    t.string   "fname",           limit: 50
    t.string   "email",           limit: 100
    t.integer  "gender"
    t.string   "role"
    t.string   "link_fb"
    t.string   "link_li"
    t.string   "link_twitter"
    t.string   "link_gplus"
    t.boolean  "display_private",             default: true
    t.string   "hobbies",         limit: 200
    t.string   "city",            limit: 50
    t.string   "country",         limit: 30
    t.string   "phone",           limit: 14
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.boolean  "admin",                       default: false
    t.string   "avatar"
    t.string   "address"
    t.string   "code_post"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
