class GradedQuizzesController < ApplicationController

  def create
    response = GraderQuizzes.new(quiz_id: graded_quizzes_params[:quiz_id], author: graded_quizzes_params[:author],
      answers: graded_quizzes_params[:answer_attributes]).estimate_note
    render json: { graded_quiz_id: response[:graded_quiz_id] }, status: response[:status]
  end

  def show
    @graded_quiz = GradedQuiz.find(params[:id])
    if @graded_quiz.present?
      render json: build_response, status: status
    else
      render json: {error: "not found a quiz with id #{params[:id]}"}, status: :not_found
    end
  end

  private
  
  def graded_quizzes_params
    params.require(:graded_quiz).permit(:quiz_id, :author, answer_attributes: [:user_answer, :question_id])
  end

  def build_response
    {quiz_id: @graded_quiz.quiz.id, author: @graded_quiz.author, score: @graded_quiz.total_score, answers: build_answers}
  end

  def build_answers
    [].tap do |array|
      @graded_quiz.answers.each{|answer| array << {question_id: answer.question_id, user_answer: answer.user_answer, correct: answer.is_correct?}}
    end
  end
end
