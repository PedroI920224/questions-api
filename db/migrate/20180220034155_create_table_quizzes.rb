class CreateTableQuizzes < ActiveRecord::Migration[5.1]
  def change
    create_table :quizzes do |t|
      t.string :subject, null: false, default: ""
    end
  end
end
