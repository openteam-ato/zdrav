class CreateHumanReservClaim < ActiveRecord::Migration
  def change
    create_table :human_reserv_claims do |t|
      t.string :fullname
      t.datetime :birthdate
      t.string :state
      t.string :old_post
      t.string :old_organization
      t.string :new_post
      t.string :new_organization
      t.datetime :reserv_date
      t.string :reserv_level
      t.string :curator_fullname
      t.datetime :appointed_date

      t.timestamps null: false
    end
  end
end
