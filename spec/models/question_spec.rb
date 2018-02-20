require "rails_helper"

describe Question, type: :model do
  it { should validate_presenc_of(:context) }
  it { should validate_presenc_of(:answer) }
  it { should validate_presenc_of(:options) }
  it { should belongs_to(:quiz) }
end
