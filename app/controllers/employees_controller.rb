class EmployeesController < ApplicationController 

	get '/signup' do 
		if logged_in?
			redirect '/tasks'
		else 
			erb :'employees/create_employee'
		end 
	end 


end