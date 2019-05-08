#!/usr/bin/env bash

#bundle install --path=vendor/cache
bundle install
bundle exec rails server -b 0.0.0.0