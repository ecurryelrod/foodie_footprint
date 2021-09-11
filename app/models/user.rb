class User < ActiveRecord::Base
    has_many :restaurants
    has_many :locations, through: :restaurants
end