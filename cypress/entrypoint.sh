#!/usr/bin/env bash
echo "Installing dependancies"
npm install

echo "Waiting on application to be ready"
/cypress/wait-for-it.sh frontend:443 -t 600

echo "Starting test"
npm run cy:run -- --record --key $CYPRESS_RECORD_KEY