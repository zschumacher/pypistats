#!/usr/bin/env bash


run_dev() {
  #TODO
  :
}

run_migration() {
  #TODO
  :
}

run() {
  if [ "$1" = "web" ]
  then
    exec poetry run uvicorn pypistats.main:app --reload
  fi
}

run "$@"