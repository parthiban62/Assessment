class CreateQuestionTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :question_types do |t|
      t.string :name
      t.boolean :descriptive, default: false
      t.timestamps
    end
  end
end
