#!/bin/bash
set -e

echo -e "Attempting deploy, if in master... \n"
if [ "$SNAP_BRANCH" == "master" ]; then 
  echo -e "Detected master branch, pushing to docker hub...\n"
  docker load -i jhauschildt-app.tar
  docker tag doot/jhauschildt:${SNAP_COMMIT_SHORT} doot/jhauschildt:stable
  docker push doot/jhauschildt:stable
  docker push doot/jhauschildt:${SNAP_COMMIT_SHORT}
else
  echo -e "Not on the master branch, won't deploy...\n"
fi