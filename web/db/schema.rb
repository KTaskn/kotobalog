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

ActiveRecord::Schema.define(version: 2019_11_30_103219) do

  create_table "access_tokens", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "token", null: false
    t.datetime "expiration", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_access_tokens_on_user_id"
  end

  create_table "books", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "isbn"
    t.string "title"
    t.string "creator", null: false
    t.string "publisher"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "refresh_tokens", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "token", null: false
    t.datetime "expiration", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_refresh_tokens_on_user_id"
  end

  create_table "sentence_likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "sentence_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sentence_id"], name: "index_sentence_likes_on_sentence_id"
    t.index ["user_id", "sentence_id"], name: "index_sentence_likes_on_user_id_and_sentence_id", unique: true
    t.index ["user_id"], name: "index_sentence_likes_on_user_id"
  end

  create_table "sentences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "user_id"
    t.string "sentence"
    t.datetime "registration_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_sentences_on_book_id"
    t.index ["user_id"], name: "index_sentences_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "access_tokens", "users"
  add_foreign_key "refresh_tokens", "users"
  add_foreign_key "sentence_likes", "sentences"
  add_foreign_key "sentence_likes", "users"
  add_foreign_key "sentences", "books"
  add_foreign_key "sentences", "users"
end
