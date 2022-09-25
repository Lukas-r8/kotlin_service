#!/usr/bin/env bash
set -eo pipefail

echo "Running Service.."
java -Dspring.profiles.active=prod -jar helloworld.jar