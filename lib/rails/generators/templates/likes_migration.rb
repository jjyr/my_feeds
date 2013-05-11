class LikesMigration < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      #this table must have xxx_identify, xxx_id, xxx_type 3 columns
      t.string :likeable_identify, null: false
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
