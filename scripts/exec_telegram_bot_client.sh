#!/bin/bash

docker-compose exec -w "/apps/telegram_bot_client" peste_api "$@"
