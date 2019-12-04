#!/bin/bash

docker-compose exec -w /apps/"$1" peste_api "${@:2}"
