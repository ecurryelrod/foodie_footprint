require 'rack-flash'

class LocationsController < ApplicationController
    use Rack::Flash

    get '/locations' do 
        @user = User.find(session[:user_id])
        erb :'/locations/locations'
    end

    get '/locations/:slug' do
        if logged_in?
            @location = Location.find_by_slug(params[:slug])
            @restaurants = @location.restaurants.where(user_id: current_user.id)
            erb :'/locations/show'
        else
            redirect to '/login'
        end
    end

    delete '/locations/:slug' do 
        @location = Location.find_by_slug(params[:slug])
        @user = @location.users.where(id: current_user.id)
        @location.users.delete(@user)
        redirect to '/locations'
    end
end