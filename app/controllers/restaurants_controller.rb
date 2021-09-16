require 'rack-flash'

class RestaurantsController < ApplicationController
    use Rack::Flash

    # get '/restaurants' do
    #     @location = Location.find(params[:id])
    #     erb :'/locations/show'
    # end

    get '/restaurants/new' do  
        if logged_in?       
            erb :'/restaurants/new'
        else
            redirect to '/login'
        end
    end

    get '/restaurants/:id' do 
        if logged_in?
            @restaurant = Restaurant.find(params[:id])
            erb :'/restaurants/show'
        else
            redirect to '/login'
        end
    end

    post '/restaurants' do 
        if logged_in?
            binding.pry
            # if params = ""
            #     flash[:message] = "Must fill in every field"
            #     redirect to '/restaurants/new'
            # else
                @restaurant = current_user.restaurants.build(params[:restaurant])
                @restaurant.location = current_user.locations.find_or_create_by(params[:location])
                # @restaurant = current_user.restaurants.find_or_create_by(params[:restaurant])
                # @restaurant.location = current_user.locations.build(params[:location])
                if @restaurant.save
                    redirect to "/restaurants/#{@restaurant.id}"
                else
                flash[:message] = "Unable to save restaurant/location. Please try again."
                redirect to '/restaurants/new'
                end
            # end
            @restaurant.location = current_user.locations.find_or_create_by(params[:location])
            # redirect to "/restaurants/#{@restaurant.id}"
        else
            redirect to '/login'
        end
    end

    get '/restaurants/:id/edit' do 
        if logged_in?
            @restaurant = Restaurant.find(params[:id])
            if @restaurant && @restaurant.user == current_user
                erb :'/restaurants/edit'
            else
                redirect to '/locations'
            end
        else
            redirect to '/login'
        end
    end

    patch '/restaurants/:id' do 
        if logged_in?
            @restaurant = Restaurant.find(params[:id])
            if params[:restaurant][:name] == "" || params[:restaurant][:food_type] == ""
                flash[:message] = "Fields cannot be blank"
                redirect to "/restaurants/#{@restaurant.id}/edit"
            else
                # binding.pry
                if @restaurant && @restaurant.user == current_user
                # @restaurant = current_user.restaurants.find(params[:id])
                    
                    if @restaurant.update(params[:restaurant])
                        redirect to "/restaurants/#{@restaurant.id}"
                    else
                        redirect to "/restaurants/#{@restaurant.id}/edit"
                    end
                else
                    redirect to '/locations'
                end
            end
                # @restaurant.location = current_user.locations.find_by(params[:location])
                # @restaurant.save
                # redirect to "/restaurants/#{@restaurant.id}"
        else
            redirect to '/login'
        end
    end

    delete '/restaurants/:id' do
        if logged_in?
            @restaurant = Restaurant.find(params[:id])
            if @restaurant && @restaurant.user = current_user
                @restaurant.delete
                redirect to '/locations'
            end
            # binding.pry
            # Restaurant.delete(params[:id])
            # redirect to '/locations'
        else
            redirect to '/login'
        end
    end
end 