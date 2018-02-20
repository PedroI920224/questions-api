FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /questions-api
WORKDIR /questions-api
COPY Gemfile /questions-api/Gemfile
COPY Gemfile.lock /questions-api/Gemfile.lock
RUN bundle install
COPY . /questions-api
