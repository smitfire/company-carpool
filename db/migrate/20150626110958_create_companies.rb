class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :email
      
      t.string :password_digest
      t.string :password_confirmation

      t.attachment :logo

      t.string :street
      t.string :city
      t.string :state
      t.string :country
      
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
