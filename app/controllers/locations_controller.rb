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
            @location = Location.find(params[:id])
            @restaurants = @location.restaurants.where(user_id: current_user.id)
            erb :'/locations/show'
        else
            redirect to '/login'
        end
    end

    # patch '/locations/:id' do 
    #     if logged_in?
    #         @location = Location.find(params[:id])
    #         if params[:location][:name] == ""
    #             flash[:message] = "Fields cannot be blank"
    #                 redirect to "/locations/#{@location.id}/edit"
    #         else
    #             if @location && @location.users.where(id: current_user.id)
    #                 if @location.update(params[:location])
    #                     redirect to '/locations'
    #                 else
    #                     redirect to "/locations/#{@location.id}/edit"
    #                 end
    #             end
    #         end
    #     end
    # end

    delete '/locations/:id' do 
        @location = Location.find(params[:id])
        @user = @location.users.where(id: current_user.id)
        @location.users.delete(@user)
        redirect to '/locations'
    end
end