class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.text :name
      t.text :post
      t.text :description

      t.timestamps
    end
  end
end
