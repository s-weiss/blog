# README

This is an api-only application.

## Preparations
* Install `mysql` on the system.
* Run `bundle install` to install necessary gems.
* Run `rake db:reset` to drop any existing version and recreate the database, and load the seed data.
* Run `rails s --binding=127.0.0.1 --port=3000` to start the application in development mode.

## Tests
Run `rake test` to start the test-suite.

## Documentation
A swagger documentation of the API can be either found:
* in swagger/swagger.yml or
* `http://127.0.0.1:3000/api-docs` 

## Authorization
I am authorizing the API calls with JWT. I need to save on all entities who created it. In order to prevent setting this explicitely and also allowing users to update other users posts / comments / reactions, I am extracting the user_id from the token.

## Concessions
In order to simulate a user session I added simple authorization via JWT. The token is however only base64 encoded for simplicity - this should not used in production.

User table is rudementary to only support a name and id.

I am finding parts of my API a bit clunky:
* /posts/{post_id}/comments/{id} seems to be unnessecary when deleting or updating a comment. However, I understood the requirement to have this as a nested resource ('delete comments on one post').
* /comments/{comment_id}/reactions/{id} - same doubts as above.
