class GradedQuizzesController < ApplicationController

  def create
    response = GraderQuizzes.new(quiz_id: graded_quizzes_params[:quiz_id], author: graded_quizzes_params[:author],
      answers: graded_quizzes_params[:answer_attributes]).estimate_note
    render json: { graded_quiz_id: response[:graded_quiz_id] }, status: response[:status]
  end

  def show
  end

  private
  
  def graded_quizzes_params
    params.require(:graded_quiz).permit(:quiz_id, :author, answer_attributes: [:user_answer, :question_id])
  end
end
