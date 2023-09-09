#!/usr/bin/env bash
set -eo pipefail

java --version
echo "Running Service.."
java -Dspring.profiles.active=prod -jar helloworld.jar