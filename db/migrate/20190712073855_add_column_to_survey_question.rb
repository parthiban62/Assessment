class AddColumnToSurveyQuestion < ActiveRecord::Migration[5.2]
  def change
  	remove_column :questions, :question_no
  	add_column :survey_questions, :question_no, :string
  end
end
