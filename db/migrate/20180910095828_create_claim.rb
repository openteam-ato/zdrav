class CreateClaim < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.string :name
      t.string :surname
      t.string :patronymic
      t.string :email
      t.string :state
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at

      t.timestamps null: false
    end
  end
end
