require "rails_helper"

RSpec.describe "Quiz Create Endpoint", type: :request do
  describe "Post /quiz" do
    context "When the quiz subject is empty" do
      before do
        @params = {quiz: {subject: "", questions_attributes: [
            {context: "What is 24 + 3?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
            {context: "What is 24 + 2?", real_answer: "B", options: {"A"=>"27", "B"=>"26", "C"=>"23"}}
          ]
        }}
      end
      it "Shuld return an error and Shouldn't created the quiz resource" do
        expect(Quiz.count).to eq(0)
        post "/quizzes", params: @params
        expect(response).to have_http_status(:bad_request)
        error_response = JSON.parse(response.body)
        expect(Quiz.count).to eq(0)
        expect(error_response).to eq({"error" => {"subject"=> ["can't be blank"]}})
      end
    end
    context "When the quiz questions are empty" do
      before do
        @params = {quiz: {subject: "Mathematics", questions_attributes: [] }}
      end
      it "Shuld return an error and Shouldn't created the quiz resource" do
        expect(Quiz.count).to eq(0)
        post "/quizzes", params: @params
        expect(response).to have_http_status(:bad_request)
        error_response = JSON.parse(response.body)
        expect(Quiz.count).to eq(0)
        expect(error_response).to eq({"error" => {"questions"=> ["There must be at least one questions to create the quiz"]}})
      end
    end
    context "When the someone question hasn't completed data" do
      context "and the context in someone question is empty" do
        before do
          @params = {quiz: {subject: "Mathematics", questions_attributes: [
              {context: "", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
              {context: "What is 24 + 2?", real_answer: "B", options: {"A"=>"27", "B"=>"26", "C"=>"23"}}
            ]
          }}
        end
        it "Shuld return an error and Shouldn't created the quiz resource" do
          expect(Quiz.count).to eq(0)
          post "/quizzes", params: @params
          expect(response).to have_http_status(:bad_request)
          error_response = JSON.parse(response.body)
          expect(Quiz.count).to eq(0)
          expect(error_response).to eq({"error" => {"questions.context"=> ["can't be blank"]}})
        end
      end
      context "and the real_answer in someone question is empty" do
        before do
          @params = {quiz: {subject: "Mathematics", questions_attributes: [
              {context: "Mathematics", real_answer: "", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
              {context: "What is 24 + 2?", real_answer: "B", options: {"A"=>"27", "B"=>"26", "C"=>"23"}}
            ]
          }}
        end
        it "Shuld return an error and Shouldn't created the quiz resource" do
          expect(Quiz.count).to eq(0)
          post "/quizzes", params: @params
          expect(response).to have_http_status(:bad_request)
          error_response = JSON.parse(response.body)
          expect(Quiz.count).to eq(0)
          expect(error_response).to eq({"error" => {"questions.real_answer"=> ["can't be blank"]}})
        end
      end
      context "and the options in someone question is empty" do
      end
    end
    context "When the params are completed with at least 3 questions" do
      before do
        @params = {quiz: {subject: "Mathematics", questions_attributes: [
            {context: "What is 26 + 1?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
            {context: "What is 24 + 2?", real_answer: "B", options: {"A"=>"27", "B"=>"26", "C"=>"23"}}
          ]
        }}
      end
      it "Shuld return success status and Should be create the Quiz resoource" do
        expect(Quiz.count).to eq(0)
        post "/quizzes", params: @params
        expect(response).to have_http_status(:created)
        expect(Quiz.count).to eq(1)
        success_response = JSON.parse(response.body)
        expect(success_response).to eq({"id" => Quiz.last.id})
      end
    end
  end
end
