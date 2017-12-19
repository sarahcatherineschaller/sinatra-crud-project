class TasksController < ApplicationController 

	get '/tasks' do 
		if logged_in?
			@tasks = current_employee.tasks
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

	post '/tasks' do 
		if params[:name] == "" || params[:due_date] == ""
			redirect '/tasks/new'
		else 
			@task = Task.create(name: params[:name], due_date: params[:due_date], employee_id: current_employee.id)
			redirect "/tasks/#{@task.id}"
		end 
	end

	get '/tasks/:id' do 
		if logged_in?
			if @task = current_employee.tasks.find_by(id: params[:id])
				erb :'/tasks/show_task'
			else 
				redirect '/tasks'
			end
		else 
			redirect '/login'
		end 
	end

	get '/tasks/:id/edit' do 
		if logged_in?
			if @task = current_employee.tasks.find_by(id: params[:id])
				erb :'/tasks/edit_task'
			else 
				redirect '/tasks'
			end
		else 
			redirect '/login'
		end 
	end

	patch '/tasks/:id' do 
		if logged_in?
			if params[:name] == "" || params[:due_date] == ""
				redirect "/tasks/#{params[:id]}/edit"
			else
				@task = current_employee.tasks.find_by(id: params[:id])
				@task.name = params[:name]
				@task.due_date = params[:due_date]
				@task.save 
				redirect "/tasks/#{@task.id}"
			end 
		else 
			redirect '/login'
		end
	end

	delete '/tasks/:id/delete' do 
		if logged_in?
			@task = current_employee.tasks.find_by(id: params[:id])
			if @task.employee_id == session[:employee_id]
				@task.delete
			end
			redirect '/tasks'
		else 
			redirect '/login'
		end 
	end
end