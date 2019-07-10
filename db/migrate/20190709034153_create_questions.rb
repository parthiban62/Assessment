class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.integer :question_type_id
      t.integer :question_no
      t.text :question_content

      t.timestamps
    end
  end
end
