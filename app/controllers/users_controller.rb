require 'rack-flash'

class UsersController < ApplicationController
    use Rack::Flash

    get '/signup' do 
        erb :'/users/signup'
    end

    post '/signup' do
        @user = User.new(params[:user])
        if @user.save 
            session[:user_id] = @user.id
            redirect to "/users/#{@user.slug}"
        else
            flash[:message] = "Try a different username or make sure all fields are filled in."
            redirect to '/signup'
        end
    end

    get '/users/:slug' do
        if logged_in?
            @user = User.find(session[:user_id])
            @locations = @user.locations.order(:name)
            erb :'/users/home'
        else
            redirect to '/'
        end
    end

    get '/users/:slug/edit' do
        if logged_in?
            @user = User.find(session[:user_id])
            erb :'/users/edit'
        else
            redirect to '/login'
        end
    end

    patch '/users/:slug' do
        if logged_in?
            @user = User.find(session[:user_id])
            @user.update(params[:user])
            flash[:message] = "Your profile has been updated."
            redirect to "/users/#{@user.slug}"
        else
            redirect to '/'
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect to '/'
        else 
            redirect to '/'
        end
    end 
end