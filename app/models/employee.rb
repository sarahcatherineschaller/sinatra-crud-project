class Employee < ActiveRecord::Base
	has_many :tasks 
	belongs_to :role 
	has_secure_password
end