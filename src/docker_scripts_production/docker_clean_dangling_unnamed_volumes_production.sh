#!/bin/sh

DEBUG=false

MINIMUM_UNNAMED_LENGTH=64

# Dangling volumes | Only use volumes that do not contain an underscore | the filtered volumes must have at least a length of MINIMUM_UNNAMED_LENGTH
VOLUMES=$(docker volume ls -f 'dangling=true' -q | grep -v '_' | sed -e "/.\{$MINIMUM_UNNAMED_LENGTH\}/!d")

if [ "$DEBUG" = "true" ]; then
  echo "Deleting docker volumes:\n"
  echo ${VOLUMES}
fi

if [ "$DEBUG" = "false" ]; then
  docker volume rm ${VOLUMES}
fi