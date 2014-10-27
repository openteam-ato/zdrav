class AddKeyToThanks < ActiveRecord::Migration
  def change
    add_column :thanks, :key, :string
  end
end
