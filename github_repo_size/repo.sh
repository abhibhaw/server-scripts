#!/usr/bin/env bash

if [ $# -eq 3 ]; then
    echo "Fetching data from github..."
    curl -s -H "Authorization: token "$1 https://api.github.com/repos/$2/$3 | jq '.size' | numfmt --to=iec --from-unit=1024
else
    echo "Please pass GitHub Token & bharatpe repo name"
fi