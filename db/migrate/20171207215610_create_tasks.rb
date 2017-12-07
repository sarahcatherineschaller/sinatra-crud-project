class CreateTasks < ActiveRecord::Migration[5.1]
  def change
  	create_table :tasks do |t|
  		t.string :name
  		t.string :due_date
  		t.integer :employee_id
  	end
  end
end
