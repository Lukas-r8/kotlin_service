#!/usr/bin/env bash
set -eo pipefail

echo "Running Service.."
pwd
echo "Contents of this dir"
ls -la
echo "MANIFEST:"
unzip -p helloworld.jar META-INF/MANIFEST.MF
echo "Run jar"
java -Dspring.profiles.active=prod -jar helloworld.jar