#!/bin/bash

docker-compose exec -w "/app/telegram_bot_client" peste_api "$@"
