FROM ruby:3.1.2

# Install NodeJS and Yarn.

RUN apt-get update && \
  apt-get install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_18.x \
  | bash -
RUN apt-get update && apt-get install -y nodejs

RUN npm install -g yarn@1.22.19

# Copy the necessary files to the container.

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

EXPOSE 3000

ENV RAILS_ENV=production
ENV SECRET_KEY_BASE=1

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
