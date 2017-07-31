#!/bin/sh

# A script that can be used as a shell alias for docker-compose to not delete named volumes by accident when calling docker-compose down.
# Tested with zsh, bash, dash ... Trying to be posix compliant.

DEBUG=false

if [ "$DEBUG" = "true" ]; then
  echo "Args Before"
  for i ; do echo "-> $i" ; done
fi

VOLUME_ARG_FOUND=false
VOLUME_COMMAND_FOUND=false
PRUNE_COMMAND_FOUND=false
DOWN_COMMAND_FOUND=false

VOLUME_ARG=''
REMAINS=''

while test $# -gt 0; do

  case "$1" in
  -v | --volume )
    VOLUME_ARG_FOUND=true
    VOLUME_ARG=$1
    ;;
  volume )
    VOLUME_COMMAND_FOUND=true
    REMAINS="$REMAINS \"$1\""
    ;;
  prune )
    PRUNE_COMMAND_FOUND=true
    REMAINS="$REMAINS \"$1\""
    ;;
  down )
    DOWN_COMMAND_FOUND=true
    REMAINS="$REMAINS \"$1\""
    ;;
  * )
    REMAINS="$REMAINS \"$1\""
    ;;
  esac

  shift

done

if [ "$VOLUME_ARG_FOUND" = "true" ] && [ "$DOWN_COMMAND_FOUND" = "true"  ]; then
  echo "------";
  echo "You have called \"docker-compose down\" including the \"-v/--volume\" argument on a production system."
  echo "This would destroy all named volumes meaning all customer data!"
  echo "Will continue without \"-v/--volume\" argument.";
  echo "------";
else
  REMAINS="$REMAINS \"$VOLUME_ARG\""
fi

# Set the non-parameters back into the positional parameters ($1 $2 ..)
eval set -- $REMAINS

if [ "$DEBUG" = "true" ]; then
  echo "Variables"
  echo "VOLUME_ARG_FOUND=$VOLUME_ARG_FOUND";
  echo "VOLUME_COMMAND_FOUND=$VOLUME_COMMAND_FOUND";
  echo "PRUNE_COMMAND_FOUND=$PRUNE_COMMAND_FOUND";
  echo "DOWN_COMMAND_FOUND=$DOWN_COMMAND_FOUND";
  echo "REMAINS=$REMAINS";

  echo "Args After:"
  for i ; do echo "-> $i" ; done
fi

eval "${REMAINS}";