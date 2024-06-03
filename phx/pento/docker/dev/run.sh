#!/bin/bash

docker compose -f docker/dev/docker-compose.yml up -d --remove-orphans --build
docker compose -f docker/dev/docker-compose.yml exec elixir bash

