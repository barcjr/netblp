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

ActiveRecord::Schema.define(:version => 20120620030738) do

  create_table "books", :force => true do |t|
    t.string   "title",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "books", ["title"], :name => "index_books_on_title", :unique => true

  create_table "contacts", :force => true do |t|
    t.integer  "book_id",            :null => false
    t.datetime "timestamp",          :null => false
    t.float    "frequency"
    t.string   "band",               :null => false
    t.string   "mode",               :null => false
    t.string   "callsign",           :null => false
    t.string   "category",           :null => false
    t.string   "section",            :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "primary_operator"
    t.string   "secondary_operator"
  end

  add_index "contacts", ["book_id", "band", "mode", "callsign"], :name => "index_contacts_on_book_id_and_band_and_mode_and_callsign"
  add_index "contacts", ["book_id", "callsign"], :name => "index_contacts_on_book_id_and_callsign"

  create_table "operators", :force => true do |t|
    t.integer  "book_id",    :null => false
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "operators", ["book_id", "name"], :name => "index_operators_on_book_id_and_name"

end
