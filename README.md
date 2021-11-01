# README

This is an api-only application.

## Preparations
* Run `bundle install` to install necessary gems.
* Run `rake db:reset` to drop any existing version and recreate the database, and load the seed data.
* Run `rails s --binding=127.0.0.1 --port=3000` to start the application in development mode.

## Documentation
A swagger documentation of the API can be either found:
* in swagger/swagger.yml or
* `http://127.0.0.1:3000/api-docs` 

## Tests
Run `rake test` to start the test-suite.

## Concessions
There is no user session. That is why the user_id has to be explicitely passed when creating a post, comment or reaction.
