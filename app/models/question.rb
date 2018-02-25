class Question < ApplicationRecord

  belongs_to :quiz, optional: true
  has_many :answers
  validates :context, :real_answer, :quiz, presence: true

end
