#!/bin/bash

docker-compose -f docker/dev/docker-compose.yml up -d
docker-compose -f docker/dev/docker-compose.yml exec elixir bash
