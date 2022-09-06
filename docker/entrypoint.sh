#!/usr/bin/env bash
set -eo pipefail

echo "Running Service.."
pwd
echo "Contents of this dir"
ls -la
java -Dspring.profiles.active=prod -jar helloworld.jar