require "rails_helper"

RSpec.describe GraderQuizzes, type: :library do
  describe "#estimate_note" do
    before do
      @quiz = Quiz.new(subject: "Mathematics")
      @qt1 = @quiz.questions.build(context: "What is 24 + 3?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"})
      @qt2 = @quiz.questions.build(context: "What is 25 + 7?", real_answer: "B", options: {"A"=>"28", "B"=>"32", "C"=>"23"})
      @qt3 = @quiz.questions.build(context: "What is 87 + 4?", real_answer: "C", options: {"A"=>"28", "B"=>"22", "C"=>"91"})
      @quiz.save
    end
    context "the params has all response questions" do
      before do
        @params = {id: @quiz.id, author: "Juanito", answer_attributes: [
            {question_id: @qt3.id, user_answer: "D"},
            {question_id: @qt1.id, user_answer: "A"},
            {question_id: @qt2.id, user_answer: "B"}
          ]
        }
      end
      it "Should create Graded Quiz with answer" do
        expect(GradedQuiz.count).to eq(0)
        grader = GraderQuizzes.new(quiz_id: @quiz.id, author: "Juanito", answers: @params[:answer_attributes])
        response = grader.estimate_note
        expect(GradedQuiz.count).to eq(1)
        graded_quiz = GradedQuiz.last
        expect(response).to eq({ status: :ok, graded_quiz_id: graded_quiz.id})
        expect(graded_quiz.author).to eq("Juanito")
        expect(graded_quiz.answers.count).to eq(3)
        expect(graded_quiz.answers.pluck(:user_answer)).to match_array(["A","D","B"])
        expect(graded_quiz.answers.pluck(:question_id)).to match_array([@qt1.id, @qt2.id, @qt3.id])
        expect(graded_quiz.total_score).to eq(66.67)
      end
    end
    context "the params has no-one response questions" do
      before do
        @params = {id: @quiz.id, author: "Juanito", answer_attributes: []}
      end
      it "Should return an error" do
        expect(GradedQuiz.count).to eq(0)
        grader = GraderQuizzes.new(quiz_id: @quiz.id, author: "Juanito", answers: @params[:answer_attributes])
        response = grader.estimate_note
        expect(GradedQuiz.count).to eq(0)
        expect(Answer.count).to eq(0)
        expect(response).to eq({status: :bad_request, error: "The number of answer cannot be zero"})
      end
    end
  end
end
