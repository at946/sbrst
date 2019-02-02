FROM ruby:2.5

ENV LANG C.UTF-8
ENV RAILS_ENV test

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install nodejs

WORKDIR /for_now_brainstorming
COPY Gemfile /for_now_brainstorming/Gemfile
COPY Gemfile.lock /for_now_brainstorming/Gemfile.lock
RUN bundle install -j4 --without production development
COPY . /for_now_brainstorming
