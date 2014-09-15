class CreateThanks < ActiveRecord::Migration
  def change
    create_table :thanks do |t|
      t.string :fullname
      t.string :email
      t.text :message

      t.timestamps
    end
  end
end
