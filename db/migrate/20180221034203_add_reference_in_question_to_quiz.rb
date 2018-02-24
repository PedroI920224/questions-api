class AddReferenceInQuestionToQuiz < ActiveRecord::Migration[5.1]
  def change
    add_reference :questions, :quiz, null: false, index: true, foreign_key: true
  end
end
