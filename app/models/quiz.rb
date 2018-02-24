class Quiz < ApplicationRecord

  NUMBER_OF_PERMITTED_QUESTIONS = 20
  validates :subject, presence: true
  has_many :questions
end
