#!/bin/sh

set -e

echo "Environment: $RAILS_ENV"

# install missing gems
bundle check || bundle install --jobs 20 --retry 5

# yarn install missing lib js
yarn install

# Remove pre-existing puma/passenger server.pid
rm -f /workspace/app/tmp/pids/server.pid

# echo "Waiting for Postgres to start..."
# while ! nc -z database_pg 5444; do sleep 0.2; done
# echo "Postgres is up"

bundle exec rake db:prepare

# run passed commands
bundle exec ${@}
