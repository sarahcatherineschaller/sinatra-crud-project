class TasksController < ApplicationController 

	get '/tasks' do 
		if logged_in?
			@task = current_employee.tasks
			erb :'tasks/tasks'
		else 
			redirect '/login'
		end 
	end 

	get '/tasks/new' do 
		if logged_in?
			erb :'/tasks/create_task'
		else
			redirect '/login'
		end 
	end

	post 'tasks' do 
		if params[:name] == "" || params[:due_date] == ""
			redirect '/tasks/new'
		else 
			employee = current_employee
			@task = Task.create(name: params[:name], due_date: params[:due_date], employee_id: employee.id)
		end 
	end

end