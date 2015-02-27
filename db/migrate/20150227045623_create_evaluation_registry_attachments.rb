class CreateEvaluationRegistryAttachments < ActiveRecord::Migration
  def change
    create_table :evaluation_registry_attachments do |t|
      t.references :evaluation_registry

      t.timestamps
    end
    add_index :evaluation_registry_attachments, :evaluation_registry_id
  end
end
