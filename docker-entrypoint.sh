#!/bin/bash

if [ -f "db/development.sqlite3" ]; then
  echo Database exists.
  bundle exec rake db:migrate RAILS_ENV=$RACK_ENV
else
  echo Database is not exist
  bundle exec rake db:create RAILS_ENV=$RACK_ENV
  bundle exec rake db:migrate RAILS_ENV=$RACK_ENV
  bundle exec rake db:seed RAILS_ENV=$RACK_ENV
fi

file="tmp/pids/server.pid"

if [ -f $file ] ; then
  rm $file
fi

bundle exec rails server -b 0.0.0.0 -P $file -e $RACK_ENV
