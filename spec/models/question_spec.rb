require "rails_helper"

describe Question, type: :model do
  it { should validate_presence_of(:context) }
  it { should validate_presence_of(:real_answer) }
  it { should allow_value({"A" => "Juanito", "B"=> "Pedrito"}).for(:options) }
  it { should belong_to(:quiz) }
  describe ".validate_limit_questions" do
    context "there aren't questions in the quiz" do
      before { @quiz = FactoryBot.create(:quiz, subject: "science")}
      context "and it is add a new question" do
        it "Should be create a new question" do
          expect(@quiz.questions.count).to be_zero
          question = Question.new(context: "who is Nicola Tesla?", options: {"A" => "Inventor", "B" => "businessman", "C" => "Baker", "D" => "Doctor"},
            real_answer: "A", quiz: @quiz)
          expect(question.save!).to be(true)
          @quiz.reload
          expect(@quiz.questions.count).to eq(1)
        end
      end
    end
  end
end
