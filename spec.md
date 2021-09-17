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
    - Users can create new restaurants and locations through the `/restaurants` URL. A user can edit a restaurant through `restaurants/:id/edit` or delete a restaurant through `/restaurants/:id/edit` URL's. Users can also delete locations associated with themselves but not from the database through `/locations/:id` URL.
- [x] Ensure that users can't modify content created by other users
    - User's can only modify their own content through:
    ```ruby
    
    ```
- [ ] Include user input validations
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [ ] You have a large number of small Git commits
- [ ] Your commit messages are meaningful
- [ ] You made the changes in a commit that relate to the commit message
- [ ] You don't include changes in a commit that aren't related to the commit message
