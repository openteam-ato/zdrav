class AddPublishedAtToThanks < ActiveRecord::Migration
  def change
    add_column :thanks, :published_at, :timestamp
  end
end
