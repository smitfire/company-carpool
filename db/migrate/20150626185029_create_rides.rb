class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.integer :user_id
      t.integer :carpool_id
      # t.boolean 
      t.boolean :driver?, :default => false

      t.timestamps null: false
    end
  end
end
