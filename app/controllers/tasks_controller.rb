class TasksController < ApplicationController 

	get '/tasks' do 
		if logged_in?
			@task = current_employee.tasks
			erb :'tasks/tasks'
		else 
			redirect '/login'
		end 
	end 

end