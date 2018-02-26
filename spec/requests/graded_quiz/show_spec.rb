require "rails_helper"

RSpec.describe "Show Graded Quiz Endpoint", type: :request do
  describe "Get /graded_quizzes/id" do
    before do
      @quiz = Quiz.new(subject: "Mathematics")
      @qt1 = @quiz.questions.build(context: "What is 24 + 3?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"})
      @qt2 = @quiz.questions.build(context: "What is 25 + 7?", real_answer: "B", options: {"A"=>"28", "B"=>"32", "C"=>"23"})
      @qt3 = @quiz.questions.build(context: "What is 87 + 4?", real_answer: "C", options: {"A"=>"28", "B"=>"22", "C"=>"91"})
      @quiz.save
      @graded_quiz = GradedQuiz.new(author: "Juanito", quiz: @quiz, total_score: 66.66)
      @ans1 = @graded_quiz.answers.build(question: @qt1, user_answer: "A")
      @ans2 = @graded_quiz.answers.build(question: @qt2, user_answer: "B")
      @ans3 = @graded_quiz.answers.build(question: @qt3, user_answer: "D")
      @graded_quiz.save
    end
    context "when the graded quiz exist" do
      before do
        @response_params = {"quiz_id" => @quiz.id, "author"=> "Juanito", "score" => "66.66",
          "answers" => [
            {"question_id" => @qt1.id, "user_answer" => "A", "correct"=> true},
            {"question_id" => @qt2.id, "user_answer" => "B", "correct" => true},
            {"question_id" => @qt3.id, "user_answer" => "D", "correct" => false},
          ]
        }
      end
      it "Should return the graded resource info" do
        get "/graded_quizzes/#{@graded_quiz.id}"
        expect(response).to have_http_status(:ok)
        success_response = JSON.parse(response.body)
        expect(success_response).to match(@response_params)
      end
    end
  end
end
