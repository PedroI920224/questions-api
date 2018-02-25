class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
       t.string :user_answer, null: false
       t.references :question, foreign_key: true
       t.references :graded_quiz, foreign_key: true
    end
  end
end
