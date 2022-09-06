#!/usr/bin/env bash
set -eo pipefail

echo "Running Service.."
pwd
echo "Contents of this dir"
ls -la

echo "running java in debug mode... 2222"
java -Xdebug -jar helloworld.jar