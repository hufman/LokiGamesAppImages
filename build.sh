#!/bin/sh

abs=`readlink -f "$0"`
cd `dirname "$abs"`

RECIPE=`echo "$1" | tr -d '/'`
DOCKER="lokigamesbuilder:`echo $RECIPE | tr -d -c 'a-zA-Z0-9'`"
echo "$DOCKER"
DOCKER_ID=`docker images -q "$DOCKER" | head -n 1`
if [ -z "$DOCKER_ID" ]; then
  cd "$RECIPE"
  docker build -t "$DOCKER" .
  DOCKER_ID=`docker images -q "$DOCKER" | head -n 1`
fi
docker run --cap-add SYS_ADMIN --device /dev/fuse --rm -ti -v /media/cdrom:/cdrom -v "`pwd`":/recipe -v "`pwd`"/out:/out "$DOCKER_ID" /bin/sh -c "cd /recipe/\"$RECIPE\" && bash -xe Recipe"
