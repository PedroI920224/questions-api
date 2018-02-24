require "rails_helper"

describe Question, type: :model do
  it { should validate_presence_of(:context) }
  it { should validate_presence_of(:real_answer) }
  it { should validate_presence_of(:quiz) }
  it { should allow_value({"A" => "Juanito", "B"=> "Pedrito"}).for(:options) }
  it { should belong_to(:quiz) }
end
