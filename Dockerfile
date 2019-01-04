FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /for_now_brainstorming
WORKDIR /for_now_brainstorming
COPY Gemfile /for_now_brainstorming/Gemfile
COPY Gemfile.lock /for_now_brainstorming/Gemfile.lock
RUN bundle install
COPY . /for_now_brainstorming
