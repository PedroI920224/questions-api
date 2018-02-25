require 'rails_helper'

describe Quiz, type: :model do
  it { should have_many(:questions) }
  it { should have_many(:graded_quizzes) }
  it { should validate_presence_of(:subject) }
  describe "#nested_created_attributes" do
    context "there aren't questions" do
      it "Shouldn't create nested Quiz" do
        params = { quiz: {subject: "Mathematics"}}
        quiz = Quiz.create(params[:quiz])
        expect(quiz.persisted?).to eq(false)
        expect(quiz.errors.messages).to eq({:questions=>["There must be at least one questions and no more than 20 questions to created the quiz"]})
      end
    end
    context "the questions attributes are less than 20 questions" do
      it "Should create nested Quiz" do
        params = { quiz: {subject: "Mathematics",
          questions_attributes: [
            {context: "What is 24 + 3?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
            {context: "What is 24 + 2?", real_answer: "B", options: {"A"=>"27", "B"=>"26", "C"=>"23"}}
          ]}
        }
        quiz = Quiz.create(params[:quiz])
        expect(quiz.persisted?).to eq(true)
      end
    end
    context "the questions attributtes are greatter than 20 questions" do
      before do
        @params = {
          quiz: {  subject: "Mathematics",
                   questions_attributes: [
                     {context: "What is 24 + 3?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
                     {context: "What is 24 + 2?", real_answer: "B", options: {"A"=>"27", "B"=>"26", "C"=>"23"}},
                     {context: "What is 23 + 3?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
                     {context: "What is 22 + 4?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
                     {context: "What is 21 + 5?", real_answer: "B", options: {"A"=>"27", "B"=>"26", "C"=>"23"}},
                     {context: "What is 20 + 6?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
                     {context: "What is 19 + 7?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
                     {context: "What is 18 + 8?", real_answer: "B", options: {"A"=>"27", "B"=>"26", "C"=>"23"}},
                     {context: "What is 17 + 9?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
                     {context: "What is 16 + 10?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
                     {context: "What is 15 + 11?", real_answer: "B", options: {"A"=>"27", "B"=>"26", "C"=>"23"}},
                     {context: "What is 14 + 12?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
                     {context: "What is 13 + 13?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
                     {context: "What is 12 + 14?", real_answer: "B", options: {"A"=>"27", "B"=>"26", "C"=>"23"}},
                     {context: "What is 11 + 15?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
                     {context: "What is 9 + 16?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
                     {context: "What is 8 + 17?", real_answer: "B", options: {"A"=>"27", "B"=>"26", "C"=>"23"}},
                     {context: "What is 7 + 18?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
                     {context: "What is 6 + 19?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
                     {context: "What is 5 + 20?", real_answer: "B", options: {"A"=>"27", "B"=>"26", "C"=>"23"}},
                     {context: "What is 3 + 21?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
                     {context: "What is 2 + 22?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
                     {context: "What is 1 + 23?", real_answer: "B", options: {"A"=>"27", "B"=>"26", "C"=>"23"}},
                     {context: "What is 0 + 24?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}}
             ]
          }
        }
      end
      it "Shouldn't create nested Quiz" do
        quiz = Quiz.create(@params[:quiz])
        expect(quiz.persisted?).to eq(false)
        expect(quiz.errors.messages).to eq({:questions=>["There must be at least one questions and no more than 20 questions to created the quiz"]})
      end
    end
  end
end
