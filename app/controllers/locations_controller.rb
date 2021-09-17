require 'rack-flash'

class LocationsController < ApplicationController
    use Rack::Flash

    get '/locations' do 
        @user = User.find(session[:user_id])
        erb :'/locations/locations'
    end

    get '/locations/:id' do
        if logged_in?
            @location = Location.find(params[:id])
            @restaurants = @location.restaurants.where(user_id: current_user.id)
            erb :'/locations/show'
        else
            redirect to '/login'
        end
    end

    delete '/locations/:id' do 
        @location = Location.find(params[:id])
        @user = @location.users.where(id: current_user.id)
        @location.users.delete(@user)
        redirect to '/locations'
    end
end