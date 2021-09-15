require 'rack-flash'

class UsersController < ApplicationController
    use Rack::Flash

    get '/signup' do 
        erb :'/users/signup'
    end

    post '/signup' do
        @user = User.new(params[:user])
        # binding.pry
        if @user.save 
            session[:user_id] = @user.id
            redirect to '/locations'
        else
            flash[:message] = "Please fill in all fields"
            redirect to '/signup'
        end
    end

    get '/account' do
        @user = User.find(session[:user_id])
        @location = Location.find_by(params[:slug])
        erb :'/users/account'
    end

    get '/logout' do
        session.clear
        redirect to '/'
    end 
end