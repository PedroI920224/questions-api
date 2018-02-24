FactoryBot.define do
  factory :quiz do
    subject "Religion"

   before :create do
     create(:question)
   end
  end
end
