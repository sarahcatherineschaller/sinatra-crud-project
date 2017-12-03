class EmployeesController < ApplicationController 

	get '/signup' do 
		if logged_in?
			redirect '/tasks'
		else 
			erb :'employees/create_employee'
		end 
	end 

	post '/signup' do 
		@errors = {}
		if params[:name] = ""
			@errors[:name] = "Name can't be blank!"
		end

		if params[:username] = ""
			@errors[:username] = "Username can't be blank!"
		elsif Employee.find_by(username: params[:username])
			@errors[:username] = "Username has already been taken!"
		end 

		if params[:password] = ""
			@errors[:password] = "Password can't be blank!"
		end 

		if params[:address] = ""
			@errors[:address] = "Address can't be blank!"
		end 

		if params[:start_date] = ""
			@errors[:start_date] = "Start Date can't be blank!"
		end 

		if @errors.empty? 
			@employee = Employee.create(name: params[:name], username: params[:username], password: params[:password], address: params[:address], start_date: params[:start_date])
			@employee.save 
			sessions[:employee_id] = @employee.id
			redirect '/show'
		else 
			erb :'employees/create_employee'
		end

	end
end