5.times {
    Restaurant.create(
        name: Faker::Restaurant.name,
        food_type: Faker::Restaurant.type
    )
}

5.times {
    Location.create(name: Faker::Nation.capital_city)
}

users = []
5.times {users << Faker::Name.name}
user_array = []

users.each do |user|
    password = user.downcase.split(" ").join("")
    user_array << {name: user, username: Faker::Internet.username, password: password}
end

user_array.each do |user|
    User.create(user)
end