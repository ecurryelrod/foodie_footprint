class Location < ActiveRecord::Base
    has_many :restaurants 
    has_many :users, through: :restaurants
    # has_many :owners, class_name: 'User'
    # belongs_to :user
    # should a location belong to a user???
end