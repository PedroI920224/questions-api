FactoryBot.define do
  factory :quiz do
    subject "Religion"

    trait :with_questions do
      questions { build_list :questions, Quiz::NUMBER_OF_PERMITTED_QUESTIONS }
    end
  end
end
