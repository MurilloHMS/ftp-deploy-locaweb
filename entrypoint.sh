#!/bin/sh -e

PROTOCOL="ftp"
if [ "$INPUT_FORCESSL" = "true" ]; then
  PROTOCOL="ftps"
fi

LOCALDIR=$(echo $INPUT_LOCALDIR | tr -d '"' | tr -d "'")
REMOTEDIR=$(echo $INPUT_REMOTEDIR | tr -d '"' | tr -d "'")

lftp -e "set dns:fatal-timeout 10; set net:timeout 10; mirror --parallel=20 --reverse --only-newer --use-cache --verbose $INPUT_OPTIONS $LOCALDIR $REMOTEDIR; quit" -u "$INPUT_USER","$INPUT_PASSWORD" "$PROTOCOL://$INPUT_HOST"