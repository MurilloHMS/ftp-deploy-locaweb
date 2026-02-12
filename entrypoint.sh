#!/bin/sh -l

set -e

lftp $INPUT_HOST -u "$INPUT_USER","$INPUT_PASSWORD" -e "
    set ftp:ssl-force $INPUT_FORCESSL;
    set ssl:verify-certificate false;
    set net:connection-limit 20;
    set net:parallel 20;
    set dns:cache-enable yes;
    mirror $INPUT_OPTIONS \
      --reverse \
      --continue \
      --dereference \
      --only-newer \
      --parallel=20 \
      --use-cache \
      -x ^\.git/$ \
      \"$INPUT_LOCALDIR\" \"$INPUT_REMOTEDIR\";
    quit"