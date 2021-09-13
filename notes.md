User
    - has_many :restaurants
    - has_many :locations, through: :restaurants
    - ??? has_many :favorite_meals, class_name: 'Meal' ???

    - has a name, username, and password_digest

Restaurant
    - has_many :diners, class_name: 'User'
    - belongs_to :location

    - has a name, food_type, location_id

Location
    - has_many :restaurants
    - has_many :users, through: :restaurants

    - has name

??? Meal
    - belongs_to :user ???