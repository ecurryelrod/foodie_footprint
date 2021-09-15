class User < ActiveRecord::Base
    has_secure_password
    validates :username, presence: true, uniqueness: true
    validates :name, presence: true

    has_many :owned_restaurants#, -> { distinct }
    has_many :owned_locations#, -> { distinct }
    has_many :restaurants, -> { distinct }
    has_many :locations, -> { distinct }, through: :restaurants
    # has_many :owned_locations, class_name: 'Location', foreign_key: 'owner_id'
    # has_many :locations
    # maybe a user just has many locations?
    # for some reason, user.locations keeps adding the same location object to it's array
    # when click on a location to see the restaurants there is nothing in the params hash.

    def slug
        self.username.parameterize
    end
    
    def self.find_by_slug(slug)
        # binding.pry
        self.all.find {|u| u.slug == slug}
    end
end