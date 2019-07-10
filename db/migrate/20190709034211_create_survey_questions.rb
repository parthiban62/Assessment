class CreateSurveyQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_questions do |t|
      t.integer :survey_id
      t.integer :question_id

      t.timestamps
    end
  end
end
