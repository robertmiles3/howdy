#!/usr/bin/env bash

docker build --build-arg APP_VERSION=$(date +"%Y.%m.%d.%H%M") -t robertmiles3/howdy:latest .
