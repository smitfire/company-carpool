class Addindextocompany < ActiveRecord::Migration
  def change
    # add_index :carpools, :driver_id
    add_index :rides, :user_id
    add_index :rides, :carpool_id
    # add_index :companies, :email, unique: true
  end
end
