FactoryBot.define do
  factory :question do
    context "who is Nicola Tesla?"
    options {{"A" => "Inventor", "B" => "businessman", "C" => "Baker", "D" => "Doctor"}}
    real_answer "A"
  end
end
