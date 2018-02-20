class Quiz < ApplicationRecord
  validates :subject, presence: true
  has_many :questions
end
