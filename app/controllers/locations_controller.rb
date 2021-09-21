require 'rack-flash'

class LocationsController < ApplicationController
    use Rack::Flash

    get '/locations/:slug' do
        if logged_in?
            @location = Location.find_by_slug(params[:slug])
            @restaurants = @location.restaurants.where(user_id: current_user.id).order(:name)
            erb :'/locations/show'
        else
            redirect to '/'
        end
    end

    delete '/locations/:slug' do 
        @location = Location.find_by_slug(params[:slug])
        @user = @location.users.where(id: current_user.id)
        @location.users.delete(@user)
        redirect to '/locations'
    end
end