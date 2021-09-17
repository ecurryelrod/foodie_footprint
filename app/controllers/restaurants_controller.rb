require 'rack-flash'

class RestaurantsController < ApplicationController
    use Rack::Flash

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
            if params[:restaurant][:name] == "" || params[:restaurant][:food_type] == "" || params[:location][:name] == ""
                flash[:message] = "Must fill in every field"
                redirect to '/restaurants/new'
            else
                @restaurant = current_user.restaurants.build(params[:restaurant])
                @restaurant.location = Location.find_or_create_by(params[:location])
                if @restaurant.save
                    redirect to "/restaurants/#{@restaurant.id}"
                else
                flash[:message] = "Unable to save restaurant/location. Please try again."
                redirect to '/restaurants/new'
                end
            end
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
                if @restaurant && @restaurant.user == current_user
                    if @restaurant.update(params[:restaurant])
                        redirect to "/restaurants/#{@restaurant.id}"
                    else
                        redirect to "/restaurants/#{@restaurant.id}/edit"
                    end
                else
                    redirect to '/login'
                end
            end
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
        else
            redirect to '/login'
        end
    end
end 