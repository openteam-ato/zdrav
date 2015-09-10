class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :code

      t.timestamps null: false
    end
  end
end
