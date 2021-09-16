class LocationsController < ApplicationController
    get '/locations' do 
        @user = User.find(session[:user_id])
        erb :'/locations/locations'
    end
    
    get '/locations/new' do 
        erb :'/locations/new'
    end

    get '/locations/:id' do
        if logged_in?
            # binding.pry
            @location = current_user.locations.find(params[:id])
            @restaurants = @location.restaurants.where(user_id: current_user.id)
            # @location = Location.find(params[:id])
            erb :'/locations/show'
        else
            redirect to '/login'
        end
    end

    post '/locations' do 
        # binding.pry
        # @restaurant = current_user.restaurants.find_or_create_by(params[:restaurant])
        @location = current_user.locations.find_or_create_by(name: params[:location][:name])
        # @restaurant.location = @location
        # @restaurant.save
        redirect to "/locations/#{@location.id}"
    end
    
    # post '/locations/:slug' do
    #     # binding.pry
    #     @location = Location.find_by_slug(params[:slug])  
    #     erb :'/locations/show'      
    # end

    get '/locations/:id/edit' do
        @location = Location.find(params[:id])
        erb :'/locations/edit'
    end

    delete '/locations/:id' do 
        Location.delete(params[:id])
        redirect to '/locations'
    end
end