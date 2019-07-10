class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.integer :survey_id
      t.integer :user_id

      t.timestamps
    end
  end
end
