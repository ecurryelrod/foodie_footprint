# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
    - ActiveRecord persists data to database through models
- [x] Include more than one model class (e.g. User, Post, Category)
    - There are models for User, Location, and Restaurant.
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
    - A User has many restaurants and has many locations through restaurants. A Location has many restaurants and has many users through restaurants.
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
    - A Restaurant belongs to a User and belongs to a Location.
- [x] Include user accounts with unique login attribute (username or email)
    - User can login with name, username (which must be unique), and secure password.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
    - Users can create new restaurants and locations through the `/restaurants` URL. A user can edit a restaurant through PATCH `restaurants/:slug` or delete a restaurant through DELETE `/restaurants/:slug` actions. Users can also delete locations associated with themselves but not from the database through DELETE `/locations/:slug` action.
- [x] Ensure that users can't modify content created by other users
    - User's can only modify their own content through ```ruby if @restaurant && @restaurant.user == current_user ``` code in each restaurant controller patch or delete action (as seen in below example):
    ```ruby
        get '/restaurants/:id/edit' do 
            if logged_in?
                @restaurant = Restaurant.find(params[:id])
                if @restaurant && @restaurant.user == current_user
                    erb :'/restaurants/edit'
                else
                    redirect to '/locations'
                end
            else
                redirect to '/login'
            end
        end
    ```
- [x] Include user input validations
    - Objects will only be persisted to the database if all required fields are filled. If not, the user will receive an error message. Example:
    ```ruby
        if params[:restaurant][:name] == "" || params[:restaurant][:food_type] == "" || params[:location][:name] == ""
                flash[:message] = "Must fill in every field"
                redirect to '/restaurants/new'
        else
        ...
        end
    ```
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
    - rack-flash posts messages related to invalid actions due to incorrect user input. (see above for example)
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
