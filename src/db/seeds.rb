# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create the global configuration
# create! makes the object and automatically saves it to the database
# the ! means that if something goes wrong and cannot save, throw an exception
AppConfig.create!(name: 'MyApp', logo_url: 'hhhhhhh')

# db/seeds.rb

user = User.first

VolunteerHour.create([
  { user: user, event_date: DateTime.now - 3.days, hours: 3.5 },
  { user: user, event_date: DateTime.now - 2.days, hours: 2.0 },
  { user: user, event_date: DateTime.now - 1.day, hours: 4.0 }
])

if Rails.env.development?

  # We're in a development mode, so making fake, insecure data is fine
  # Create two user profiles, admin and unprivledged user
  # Right now, there is no difference between the accounts
  # If your project needs it, add a boolean field to user for administrator
  admin = User.find_or_create_by!(email: 'admin@example.com') do |u|
    u.password = 'password'
    u.password_confirmation = 'password'
  end
  
  user = User.find_or_create_by!(email: 'user@example.com') do |u|
    u.password = 'password'
    u.password_confirmation = 'password'
  end

elsif Rails.env.production?

  # We're in a production application! Stay secure! No accounts with password!

end
