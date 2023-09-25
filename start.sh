#!/bin/bash

rm -f /app/tmp/pids/server.pid

bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed without_subscribers=1

bundle exec rails s -b 0.0.0.0