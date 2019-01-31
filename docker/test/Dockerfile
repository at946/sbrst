FROM ruby:2.5

ENV LANG C.UTF-8
ENV RAILS_ENV test

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /for_now_brainstorming
COPY Gemfile /for_now_brainstorming/Gemfile
COPY Gemfile.lock /for_now_brainstorming/Gemfile.lock
RUN bundle install -j4
COPY . /for_now_brainstorming
