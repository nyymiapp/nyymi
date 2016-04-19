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

ActiveRecord::Schema.define(version: 20160418132217) do

  create_table "applications", force: :cascade do |t|
    t.integer  "open_job_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "freetext"
    t.boolean  "abandoned"
    t.string   "invitationsended"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "location"
    t.string   "website"
  end

  create_table "companies_users", id: false, force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "user_id",    null: false
  end

  create_table "conversation_channels", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "channel"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "channel"
    t.string   "userchannel"
  end

  create_table "experiences", force: :cascade do |t|
    t.integer  "application_id"
    t.string   "place"
    t.string   "description"
    t.date     "start"
    t.date     "end"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "strictplace"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "conversation_id"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "sendername"
    t.boolean  "seen"
  end

  create_table "open_jobs", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "name"
    t.text     "description"
    t.date     "expires"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "companyname"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "email"
    t.string   "phonenumber"
    t.string   "realname"
    t.string   "channel"
    t.string   "sendername"
  end

end
