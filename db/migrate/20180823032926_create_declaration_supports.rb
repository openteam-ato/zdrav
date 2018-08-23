class CreateDeclarationSupports < ActiveRecord::Migration
  def change
    create_table :declaration_supports do |t|
      t.string :name
      t.string :surname
      t.string :patronymic
      t.string :job
      t.boolean :agreement
      t.string :email

      t.timestamps null: false
    end
  end
end
