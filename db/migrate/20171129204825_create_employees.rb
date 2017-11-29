class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
  	create_table :employees do |t|
  		t.string :name 
  		t.string :username 
  		t.text :address
  		t.string :password_digest 
  		t.date :start_date 
  		t.integer :role_id
  	end 
  end
end
