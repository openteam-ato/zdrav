class CreateVideoMessages < ActiveRecord::Migration
  def change
    create_table :video_messages do |t|
      t.string :target
      t.string :title
      t.string :name
      t.string :phone
      t.string :email
      t.string :aasm_state

      t.timestamps null: false
    end
  end
end
