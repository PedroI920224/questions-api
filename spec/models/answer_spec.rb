require "rails_helper"

describe Answer, type: :model do
  it {should validate_presence_of(:user_answer)}
  it {should validate_presence_of(:graded_quiz)}
  it {should validate_presence_of(:question)}
  it {should belong_to(:graded_quiz)}
  it {should belong_to(:question)}
end
