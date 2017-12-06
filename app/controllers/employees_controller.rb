class EmployeesController < ApplicationController 

	get '/signup' do 
		if logged_in?
			redirect '/show'
		else 
			@errors = {}
			erb :'employees/create_employee'
		end 
	end 

	post '/signup' do 
		@errors = {}
		if params[:name] == ""
			@errors[:name] = "Name can't be blank!"
			redirect '/signup'
		end

		if params[:username] == ""
			@errors[:username] = "Username can't be blank!"
			redirect '/signup'
		elsif Employee.find_by(username: params[:username])
			@errors[:username] = "Username has already been taken!"
			redirect '/signup'
		end 

		if params[:password] == ""
			@errors[:password] = "Password can't be blank!"
			redirect '/signup'
		end 

		if params[:address] == ""
			@errors[:address] = "Address can't be blank!"
			redirect '/signup'
		end 

		if params[:start_date] == ""
			@errors[:start_date] = "Start Date can't be blank!"
			redirect '/signup'
		end 

		if @errors.empty? 
			@employee = Employee.create(name: params[:name], username: params[:username], password: params[:password], address: params[:address], start_date: params[:start_date], role_id: params[:role_id])
			@employee.save 
			session[:employee_id] = @employee.id
			redirect '/tasks'
		else 
			erb :'employees/create_employee'
		end
	end

	get '/login' do 
		if logged_in? 
			redirect '/tasks'
		else 
			erb :'employees/login'
		end 
	end

	post '/login' do 
		employee = Employee.find_by(username: params[:username])
		if employee && employee.authenticate(params[:password])
			session[:employee_id] = employee.id
			redirect '/tasks'
		else 
			redirect '/signup'
		end 
	end 

	get '/logout' do 
		if logged_in?
			session.clear 
			redirect '/login'
		else 
			redirect '/'
		end 
	end


end