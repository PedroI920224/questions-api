require 'rails_helper'

describe GradedQuiz, typ: :model do
  it { should validate_presence_of(:author}
  it { should validate_presence_of(:total_score}
end
