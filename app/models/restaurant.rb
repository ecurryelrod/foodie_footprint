class Restaurant < ActiveRecord::Base
    belongs_to :user
    belongs_to :location

    # validates :name, presence: true

    def slug
        self.name.parameterize
    end
    
    def self.find_by_slug(slug)
        self.all.find {|r| r.slug == slug}
    end
end