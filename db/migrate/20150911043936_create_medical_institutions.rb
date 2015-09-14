class CreateMedicalInstitutions < ActiveRecord::Migration
  def change
    create_table :medical_institutions do |t|
      t.string :title
      t.timestamps null: false
    end
  end
end
