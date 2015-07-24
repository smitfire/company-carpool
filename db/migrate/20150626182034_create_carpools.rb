class CreateCarpools < ActiveRecord::Migration
  def change
    create_table :carpools do |t|
      t.datetime :date
      t.string :name
      t.integer :capacity
      t.integer :range
      # t.integer :driver_id
      
      t.timestamps null: false
    end
  end
end
