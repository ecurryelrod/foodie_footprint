class Location < ActiveRecord::Base
    has_many :restaurants 
    has_many :users, through: :restaurants

    def slug
        self.name.parameterize
    end
    
    def self.find_by_slug(slug)
        self.all.find {|l| l.slug == slug}
    end

    def remove_location_from_user

    end
end