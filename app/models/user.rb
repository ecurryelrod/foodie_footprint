class User < ActiveRecord::Base
    has_secure_password
    validates :username, presence: true, uniqueness: true
    validates :name, presence: true

    has_many :restaurants, -> { distinct }
    has_many :locations, -> { distinct }, through: :restaurants
    

    def slug
        self.username.parameterize
    end
    
    def self.find_by_slug(slug)
        # binding.pry
        self.all.find {|u| u.slug == slug}
    end
end