class QuizzesController < ApplicationController
  def create
    quiz = Quiz.new(quiz_params)
    if quiz.save
      render json: {id: quiz.id}, status: :created
    else
      render json: {error: quiz.errors.messages}, status: :bad_request
    end
  end

  private
  
  def quiz_params
    params.require(:quiz).permit(:subject, questions_attributes: [:context, :real_answer, options:[]])
  end
end
