class Question < ApplicationRecord
  belongs_to :quiz
  validates :context, :real_answer, presence: true
end
