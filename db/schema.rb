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

ActiveRecord::Schema.define(version: 20180225215504) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "answers", force: :cascade do |t|
    t.string "user_answer", null: false
    t.bigint "question_id"
    t.bigint "graded_quiz_id"
    t.index ["graded_quiz_id"], name: "index_answers_on_graded_quiz_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "graded_quizzes", force: :cascade do |t|
    t.string "author", null: false
    t.decimal "total_score", default: "0.0", null: false
    t.bigint "quiz_id"
    t.index ["quiz_id"], name: "index_graded_quizzes_on_quiz_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "context", null: false
    t.string "real_answer", null: false
    t.hstore "options", default: {}, null: false
    t.bigint "quiz_id", null: false
    t.index ["quiz_id"], name: "index_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "subject", default: "", null: false
  end

  add_foreign_key "answers", "graded_quizzes"
  add_foreign_key "answers", "questions"
  add_foreign_key "graded_quizzes", "quizzes"
  add_foreign_key "questions", "quizzes"
end
