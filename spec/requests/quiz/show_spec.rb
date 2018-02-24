require "rails_helper"

RSpec.describe "Show Quiz Endpoint", type: :request do
  describe "Get /quiz/:id" do
    context "the Quiz resource doesn't exist in the database" do
      it "Should return not found" do
        get "/quizzes/3"
        expect(response).to have_http_status(:not_found)
        not_found_response = JSON.parse(response.body)
        expect(not_found_response).to eq({"error" => "not found a quiz with id 3"})
      end
    end
    context "the Quiz resource exist in the database" do
      before do
         @quiz = Quiz.new(subject: "Mathematics")
         @qt1 = @quiz.questions.build(context: "What is 24 + 3?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"})
         @qt2 = @quiz.questions.build(context: "What is 24 + 4?", real_answer: "A", options: {"A"=>"28", "B"=>"22", "C"=>"23"})
         @quiz.save
      end
      it "Should return the quiz resource with the ids" do
        expected_response = {
          "data" => {
            "quiz_id" => @quiz.id,
            "subject" => "Mathematics",
            "questions"=> [
              {"question_id" => @qt1.id, "context" => "What is 24 + 3?", "options" => {"A"=>"27", "B"=>"22", "C"=>"23"}},
              {"question_id" => @qt2.id, "context" => "What is 24 + 4?", "options" => {"A"=>"28", "B"=>"22", "C"=>"23"}}
            ]
          }
        }

        get "/quizzes/#{@quiz.id}"

        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to match(expected_response)
      end
    end
  end
end
