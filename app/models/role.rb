class Role < ActiveRecord::Base
	has_many :employees 
	has_many :tasks, through: :employees
end