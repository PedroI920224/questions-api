class GradedQuiz < ApplicationRecord
  validates :author, :total_score, presence: true
  belongs_to :quiz
  has_many :answers
end
