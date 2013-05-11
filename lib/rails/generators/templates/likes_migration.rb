class MyFeedsMigration < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.string :source_identify, null: false
      t.references :likeable, :polymorphic => true, :null => false

      #you maybe need change this column
      t.references :user

      t.timestamps
    end

    #indexes
    #add_index :likes, [:user_id, :likeable_id, :likeable_type], :unique => true
    #add_index :likes, :user_id
  end
end
