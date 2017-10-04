# Escelera
This Repo hosts the code for Car Rental App based on Ruby and Rails as a part of OODD course.

[1]: http://rent-godrive.herokuapp.com

## Team Members
* Amit Kanwar (akanwar2)
* Kamal Sharma (ksharma5)
* Rachit Agarwal (ragarwa7)

## Deployment
The production build of the app is deployed on [Heroku][1]

## Test Data
* Superadmin (email:'sadmin@abc.com', password: 'sadmin')
* admin(email: 'amith@abc.com', password: 'amith123')
## Development
To run the app locally, follow these stops:

### Install gems
```
bundle install --without production
```

### Complete Database Migrations
```
rails db:migrate
```

### Add pre-configured superadmins, admins and users
```
rails db:seed
```

### Run server
```
rails server
```

Your app will run on http://localhost:3000
