class Answer < ApplicationRecord
  validates :user_answer, :graded_quiz, :question, presence: true
  belongs_to :graded_quiz
  belongs_to :question

  def is_correct?
    user_answer.eql?(question.real_answer)
  end
end
