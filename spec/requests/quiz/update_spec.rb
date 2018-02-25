require "rails_helper"

RSpec.describe "Update Quiz Endpoint", type: :request do
  describe "Put /quiz/:id" do
    context "when the Quiz resource exist in the database" do
      before do
        @quiz = Quiz.new(subject: "Mathematics")
        @qt1 = @quiz.questions.build(context: "What is 24 + 3?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"})
        @qt2 = @quiz.questions.build(context: "What is 24 + 4?", real_answer: "A", options: {"A"=>"28", "B"=>"22", "C"=>"23"})
        @quiz.save
      end
      context "The subject is empty" do
        before do
          @params = {quiz: {subject: "", questions_attributes: [
                {quiz_id: @qt1.id, context: "What is 24 + 3?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
                {quiz_id: @qt2.id, context: "What is 24 + 2?", real_answer: "B", options: {"A"=>"27", "B"=>"26", "C"=>"23"}}
              ]
            }
          }
        end
        it "Shouldn't update the resource" do
          put "/quizzes/#{@quiz.id}", params: @params
          expect(response).to have_http_status(:bad_request)
          error_response = JSON.parse(response.body)
          expect(error_response).to eq({"error" => {"subject"=> ["can't be blank"]}})
        end
      end
      context "when the params has correct new data" do
        before do
          @params = {quiz: {subject: "Religion", questions_attributes: [
                {id: @qt1.id, context: "What is 30 + 30?", real_answer: "A", options: {"A"=>"60", "B"=>"22", "C"=>"23"}},
                {id: @qt2.id, context: "What is 29 + 29?", real_answer: "B", options: {"A"=>"27", "B"=>"58", "C"=>"23"}}
              ]
            }
          }
        end
        it "Shold update the resource" do
          put "/quizzes/#{@quiz.id}", params: @params
          expect(response).to have_http_status(:ok)
          success_response = JSON.parse(response.body)
          expect(success_response).to eq({"quiz_id" => @quiz.id})
          @quiz.reload
          expect(@quiz.subject).to eq("Religion")
          @qt1.reload
          expect(@qt1.context).to eq("What is 30 + 30?")
          expect(@qt1.options).to match({"A"=>"60", "B"=>"22", "C"=>"23"})
          @qt2.reload
          expect(@qt2.context).to eq("What is 29 + 29?")
          expect(@qt2.options).to match({"A"=>"27", "B"=>"58", "C"=>"23"})
        end
      end
    end
  end
end
