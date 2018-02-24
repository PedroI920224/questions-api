class QuizzesController < ApplicationController

  def show
    @quiz = Quiz.find_by_id(params[:id])
    if @quiz.present?
      render json: build_response, status: status
    else
      render json: {error: "not found a quiz with id #{params[:id]}"}, status: :not_found
    end
  end

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

  def build_response
    {data: {quiz_id: @quiz.id, subject: @quiz.subject, questions: build_questions}}
  end

  def build_questions
    [].tap do |array|
      @quiz.questions.each{|question| array << {question_id: question.id, context: question.context, options: question.options}}
    end
  end

end
