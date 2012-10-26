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

ActiveRecord::Schema.define(:version => 20121026104140) do

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "foreign_title"
    t.string   "first_category"
    t.string   "second_category"
    t.string   "author"
    t.string   "publisher"
    t.datetime "published_at"
    t.string   "language"
    t.string   "size"
    t.integer  "last_page"
    t.string   "isbn10"
    t.string   "isbn13"
    t.integer  "price"
    t.integer  "reviewed"
    t.text     "description"
    t.text     "index"
    t.string   "series"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "villages", :force => true do |t|
    t.string   "url"
    t.string   "si"
    t.string   "gu"
    t.string   "dong"
    t.string   "village"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
