require 'rack-flash'

class LocationsController < ApplicationController
    use Rack::Flash

    get '/locations' do 
        @user = User.find(session[:user_id])
        erb :'/locations/locations'
    end
    
    get '/locations/new' do 
        erb :'/locations/new'
    end

    get '/locations/:id' do
        if logged_in?
            # @location = current_user.locations.find(params[:id])
            @location = Location.find(params[:id])
            @restaurants = @location.restaurants.where(user_id: current_user.id)
            erb :'/locations/show'
        else
            redirect to '/login'
        end
    end

    # post '/locations' do 
    #     if logged_in?
    #         @location = Location.find_or_create_by(params[:location])
    #         redirect to "/locations/#{@location.id}"
    #         # @restaurant = current_user.restaurants.find_or_create_by(params[:restaurant])
    #         # @restaurant.location = @location
    #         # @restaurant.save
    #     else
    #         redirect to '/login'
    #     end
    # end
    
    # post '/locations/:slug' do
    #     # binding.pry
    #     @location = Location.find_by_slug(params[:slug])  
    #     erb :'/locations/show'      
    # end

    # get '/locations/:id/edit' do
    #     if logged_in?
    #         # binding.pry
    #         @location = Location.find(params[:id])
    #         erb :'/locations/edit'
    #     else
    #         redirect to '/login'
    #     end
    # end

    patch '/locations/:id' do 
        if logged_in?
            @location = Location.find(params[:id])
            if params[:location][:name] == ""
                flash[:message] = "Fields cannot be blank"
                    redirect to "/locations/#{@location.id}/edit"
            else
                # binding.pry
                if @location && @location.users.where(id: current_user.id)
                    if @location.update(params[:location])
                        redirect to '/locations'
                    else
                        redirect to "/locations/#{@location.id}/edit"
                    end
                end
            end
        end
    end

    delete '/locations/:id' do 
        # binding.pry
        @location = Location.find(params[:id])
        @user = @location.users.where(id: current_user.id)
        @location.users.delete(@user)
        # current_user.locations.where(id: current_user.id).delete(params[:id])
        redirect to '/locations'
    end
end