class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.integer :user_id
      t.integer :carpool_id
      
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      
      t.float :latitude
      t.float :longitude

      t.boolean :driver?, :default => false
      t.timestamps null: false
    end
  end
end
