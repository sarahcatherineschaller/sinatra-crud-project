require './config/environment'

class ApplicationController < Sinatra::Base

	configure do 
		set :public_folder, 'public' 
		set :views, 'app/views'
		enable :sessions
		set :session_secret, 'password_security'
	end 

	get '/' do 
		erb :index 
	end 

	helpers do 
		def logged_in? 
			!!current_employee
		end 

		def current_employee 
			@current_employee ||= Employee.find_by(id: session[:employee_id]) if session[:employee_id]
		end
	end
end