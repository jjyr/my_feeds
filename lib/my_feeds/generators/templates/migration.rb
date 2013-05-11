class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      #necessarily
      t.references :source, :polymorphic => true, :null => false
      t.string :event, null: false

      #not necessarily, but maybe you need
      #you can also customize your columns
      t.references :target, :polymorphic => true

      t.timestamps
    end

    add_index :feeds, ["source_id", "source_type"]
    #add_index :feeds, [:source_type, :source_id, :event, :target_id, :target_type], unique: true
  end
end
