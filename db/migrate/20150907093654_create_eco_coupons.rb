class CreateEcoCoupons < ActiveRecord::Migration
  def change
    create_table :eco_coupons do |t|
      t.string :number
      t.string :patient_code
      t.datetime :issued_at
      t.datetime :closing_at

      t.timestamps
    end
  end
end
