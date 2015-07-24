class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, unique: true
      
      t.string :password_digest
      t.string :password_confirmation
      
      t.attachment :avatar
      
      t.string :building

      # t.string :street
      # t.string :city
      # t.string :state
      # t.string :country
      
      # t.float :latitude
      # t.float :longitude

      t.integer :company_id
      
      t.timestamps null: false
    end
  end
end
