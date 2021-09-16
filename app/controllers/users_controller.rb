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
            flash[:message] = "Try a different username or make sure all fields are filled in."
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