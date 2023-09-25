FROM ruby:3.2.2

RUN apt-get update && apt-get install -y nodejs

WORKDIR /app
COPY Gemfile* ./
COPY Gemfile.lock ./
RUN bundle install

WORKDIR /app
COPY . ./

WORKDIR /app

ENV RAILS_ENV=development
ENV SECRET_KEY_BASE=temp_for_prod_assets_precompile

EXPOSE 3000

CMD ["rails", "server"]
