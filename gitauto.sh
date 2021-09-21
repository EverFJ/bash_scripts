#!/bin/bash
# A super simple yet time-saving script for committing and pushing on github

comment="$1"

git add . && git commit -m "$comment" && git push

exit 0
