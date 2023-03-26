FROM ruby:3.2.1

WORKDIR /whisprite

RUN gem update --system
RUN gem install bundler

COPY . .

RUN bundle install

CMD ["bundle", "exec", "bin/whisprite"]
