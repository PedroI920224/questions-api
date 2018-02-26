# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

#### This is the tools necesaries to update the project
* Ruby version: 2.3.3
* Ruby On Rails: 5.1.5
* Docker compose: version 3
* Concepts of API RESTFUL
* Concepts of TDD and BDD(Rspec Documentation)

#### Configuration
- to update the database is necessary run:
* sudo docker-compose run web rails db:create
* sudo docker-compose run web rails db:migrate
* sudo docker-compose run web rails db:test:prepare

#### How to run the test suite
- To run the test suite is necessary run:
* sudo docker-compose run web bundle exec rspec spec/

#### Deployment instructions
