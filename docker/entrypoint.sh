#!/usr/bin/env bash
set -eo pipefail

echo "Running Service...123"
pwd
echo "Contents of this dir"
ls -la
echo "contents of previous folder..."
ls -la ..
java -jar /helloworld.jar