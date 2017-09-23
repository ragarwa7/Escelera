# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create :name => 'Amith' , :email => 'amith@abc.com', :password => 'amith123', :role => 1
User.create :name => 'SAdmin' , :email => 'sadmin@abc.com', :password => 'sadmin', :role => 2
User.create :name => 'kamal' , :email => 'kamal@abc.com', :password => 'kamal123', :role => 0
User.create :name => 'Yash' , :email => 'ybajori@ncsu.edu', :password => 'yash123', :role => 2
User.create :name => 'Racs', :email => 'rachit.grwl9@gmail.com', :password => 'racs123', :role => 1
User.create :name => 'Rachit' , :email => 'ragarwa@ncsu.edu', :password => 'rachit123', :role => 0
