class CreateShares < ActiveRecord::Migration[5.2]
  def change
    create_table :shares do |t|
      t.integer :survey_id
      t.string :email

      t.timestamps
    end
  end
end
