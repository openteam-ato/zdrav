class CreateTestResults < ActiveRecord::Migration
  def change
    create_table :test_results do |t|
      t.integer :right_answers
      t.text :answers
      t.references :claim, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
