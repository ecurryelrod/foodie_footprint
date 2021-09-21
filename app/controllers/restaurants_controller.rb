require 'rack-flash'

class RestaurantsController < ApplicationController
    use Rack::Flash

    get '/restaurants/new' do  
        redirect_if_not_logged_in
        erb :'/restaurants/new'
    end

    get '/restaurants/:slug' do 
        redirect_if_not_logged_in
        @restaurant = Restaurant.find_by_slug(params[:slug])
        erb :'/restaurants/show'
    end

    post '/restaurants' do 
        redirect_if_not_logged_in
        if params[:restaurant][:name] == "" || params[:restaurant][:food_type] == "" || params[:location][:name] == ""
            flash[:message] = "You must fill in every field"
            redirect to '/restaurants/new'
        else
            @restaurant = current_user.restaurants.build(params[:restaurant])
            @restaurant.location = Location.find_or_create_by(params[:location])
            if @restaurant.save
                redirect to "/restaurants/#{@restaurant.slug}"
            else
                flash[:message] = "Unable to save. Please try again."
                redirect to '/restaurants/new'
            end
        end
    end

    get '/restaurants/:slug/edit' do 
        redirect_if_not_logged_in
        @restaurant = Restaurant.find_by_slug(params[:slug])
        if @restaurant && @restaurant.user == current_user
            erb :'/restaurants/edit'
        else
            redirect to "users/#{current_user.slug}"
        end
    end

    patch '/restaurants/:slug' do 
        redirect_if_not_logged_in
        @restaurant = Restaurant.find_by_slug(params[:slug])
        if params[:restaurant][:name] == "" || params[:restaurant][:food_type] == ""
            flash[:message] = "Fields cannot be blank"
            redirect to "/restaurants/#{@restaurant.slug}/edit"
        else
            if @restaurant && @restaurant.user == current_user
                if @restaurant.update(params[:restaurant])
                    flash[:message] = "Restaurant has been updated."
                    redirect to "/restaurants/#{@restaurant.slug}"
                else
                   redirect to "/restaurants/#{@restaurant.slug}/edit"
                end
            else
                redirect to "/users/#{current_user.slug}"
            end
        end
    end

    delete '/restaurants/:slug' do
        redirect_if_not_logged_in
        @restaurant = Restaurant.find_by_slug(params[:slug])
        if @restaurant && @restaurant.user = current_user
            @restaurant.delete
            redirect to "users/#{current_user.slug}"
        end
    end
end 