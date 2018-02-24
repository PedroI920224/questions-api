class Question < ApplicationRecord

  belongs_to :quiz, optional: true
  validates :context, :real_answer, :quiz, presence: true

end
