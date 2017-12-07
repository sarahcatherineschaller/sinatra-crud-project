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
			redirect "/tasks/#{@task.id}"
		end 
	end

	get '/tasks/:id' do 
		if logged_in?
			@task = Task.find_by(params[:id])
			erb :'/tasks/show_task'
		else 
			redirect '/login'
		end 
	end

	get '/tasks/:id/edit' do 
		if logged_in?
			@task = Task.find_by(params[:id])
			erb :'/tasks/edit_task'
		else 
			redirect '/login'
		end 
	end

	patch '/tasks/:id' do 
		if params[:name] == "" || params[:due_date] == ""
			redirect "/tasks/#{params[:id]}/edit"
		else
			@task = Task.find_by(params[:id])
			@task.name = params[:name]
			@task.due_date = params[:due_date]
			@task.save 
			redirect "/tasks/#{@task.id}"
		end 
	end


	delete '/tasks/:id/delete' do 
		if logged_in?
			@task = Task.find_by(params[:id])
			if @task.employee_id == session[:employee_id]
				@task.delete
				redirect '/tasks'
			else
				redirect '/tasks'
			end 
		else 
			redirect '/login'
		end 
	end
end