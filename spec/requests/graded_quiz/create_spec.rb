require "rails_helper"

RSpec.describe "Create Grade Quiz Endpoint", type: :request do
  describe "Post /graded_quizzes" do
    before do
      @quiz = Quiz.new(subject: "Mathematics")
      @qt1 = @quiz.questions.build(context: "What is 24 + 3?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"})
      @qt2 = @quiz.questions.build(context: "What is 25 + 7?", real_answer: "B", options: {"A"=>"28", "B"=>"32", "C"=>"23"})
      @qt3 = @quiz.questions.build(context: "What is 87 + 4?", real_answer: "C", options: {"A"=>"28", "B"=>"22", "C"=>"91"})
      @quiz.save
    end
    context "When the all params is correct" do
      before do
        @params = { graded_quiz: {
            quiz_id: @quiz.id, author: "Juanito", answer_attributes: [
              {question_id: @qt3.id, user_answer: "D"},
              {question_id: @qt1.id, user_answer: "A"},
              {question_id: @qt2.id, user_answer: "B"}
            ]
          }
        }
      end
      it "Should return an success status and should be create Quiz" do
        expect(GradedQuiz.count).to eq(0)
        post "/graded_quizzes", params: @params
        expect(response).to have_http_status(:ok)
        success_response = JSON.parse(response.body)
        graded_quiz = GradedQuiz.last
        expect(success_response).to eq({"graded_quiz_id" => graded_quiz.id})
        expect(graded_quiz.author).to eq("Juanito")
        expect(graded_quiz.answers.count).to eq(3)
        expect(graded_quiz.answers.pluck(:user_answer)).to match_array(["A","D","B"])
        expect(graded_quiz.answers.pluck(:question_id)).to match_array([@qt1.id, @qt2.id, @qt3.id])
        expect(graded_quiz.total_score).to eq(66.67)
      end
    end
  end
end
