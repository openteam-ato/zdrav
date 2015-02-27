class CreateEvaluationRegistries < ActiveRecord::Migration
  def change
    create_table :evaluation_registries do |t|
      t.text :title
      t.integer :question_1_1
      t.integer :question_1_2
      t.integer :question_1_3
      t.integer :question_1_4
      t.integer :question_1_5
      t.integer :question_1_6
      t.integer :question_1_7
      t.integer :question_1_8
      t.integer :question_1_9
      t.integer :question_1_10
      t.integer :question_1_11
      t.integer :question_2_1
      t.integer :question_2_2
      t.integer :question_2_3
      t.integer :question_2_4
      t.integer :question_2_5
      t.integer :question_2_6
      t.integer :question_2_7
      t.integer :question_2_8
      t.integer :question_2_9
      t.integer :question_3_1
      t.integer :question_3_2
      t.integer :question_3_3
      t.integer :question_3_4
      t.integer :question_3_5
      t.integer :question_3_6
      t.integer :question_4_1
      t.integer :question_4_2
      t.integer :question_4_3
      t.integer :question_5_1
      t.integer :question_5_2
      t.text :proposal

      t.timestamps
    end
  end
end
