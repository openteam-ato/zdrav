class AddAuthorizeTokeToClaim < ActiveRecord::Migration
  def change
    add_column :claims, :authorize_token, :string
  end
end
