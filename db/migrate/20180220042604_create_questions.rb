class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    enable_extension "hstore"
    create_table :questions do |t|
      t.string :context, null: false
      t.string :real_answer, null: false
      t.hstore :options, null: false, default: {}
    end
  end
end
