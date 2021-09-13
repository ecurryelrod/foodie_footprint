class User < ActiveRecord::Base
    has_secure_password
    validates :username, presence: true, uniqueness: true
    validates :name, presence: true

    has_many :restaurants
    has_many :locations, through: :restaurants
    # has_many :owned_locations, class_name: 'Location', foreign_key: 'owner_id'
    # has_many :locations
    # maybe a user just has many locations?
    # for some reason, user.locations keeps adding the same location object to it's array
    # when click on a location to see the restaurants there is nothing in the params hash.
end