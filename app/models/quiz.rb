class Quiz < ApplicationRecord
  NUMBER_OF_PERMITTED_QUESTIONS = 20

  has_many :questions
  has_many :graded_quizzes
  validates :subject, presence: true
  validate :validate_max_size

  accepts_nested_attributes_for :questions

  def validate_max_size
    if (questions.empty? || (questions.size >= NUMBER_OF_PERMITTED_QUESTIONS))
      errors.add(:questions, :invalid_number_of_questions, message: "There must be at least one questions and no more than 20 questions to created the quiz")
    end
  end
end
