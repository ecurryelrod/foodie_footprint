class RestaurantsController < ApplicationController
    post '/restaurants' do
        @Restaurants = Restaurant.all.select do |location| 
            binding.pry
            restaurant.location_id == location
        end
        erb :'/restaurants/restaurants'
    end
end 