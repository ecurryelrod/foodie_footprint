class Location < ActiveRecord::Base
    has_many :restaurants 
    has_many :users, through: :restaurants
    # belongs_to :user
    # should a location belong to a user???

    validates :name, presence: true

    def slug
        self.name.parameterize
    end
    
    def self.find_by_slug(slug)
        self.all.find {|l| l.slug == slug}
    end
end