class GraderQuizzes
  def initialize(quiz_id:, author:, answers: [])
    @quiz = Quiz.find(quiz_id)
    @author = author
    @answers = answers
    @correct_answers = 0
  end

  def estimate_note
    @answers.count.zero? ? {error: "The number of answer cannot be zero", status: :bad_request} : calculate_note
  end

  private
  
  def calculate_note
    if build_graded_quiz.save
      {status: :ok, graded_quiz_id: graded_quiz.id}
    else
      {status: :bad_request}
    end
  end

  def graded_quiz
    @graded_quiz ||= GradedQuiz.new(author: @author, quiz: @quiz)
  end

  def create_answers
    @answers.each do |answer|
      graded_quiz.answers.build(user_answer: answer[:user_answer], question_id: answer[:question_id])
    end
  end

  def build_note
    graded_quiz.answers.each do |answer|
      @correct_answers += 1 if answer.is_correct?
    end
  end

  def assign_score
    graded_quiz.total_score = ((@correct_answers.to_f/total_questions.to_f)*100).round(2)
  end

  def total_questions
    total_questions ||= @quiz.questions.count
  end

  def build_graded_quiz
    create_answers
    build_note
    assign_score
    graded_quiz
  end
end
