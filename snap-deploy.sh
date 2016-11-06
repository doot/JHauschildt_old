#!/bin/bash

if [ "$SNAP_BRANCH" == "master" ]; then 
  echo "Detected master branch, pushing to docker hub..."
  docker load -i jhauschildt-app.tar
  docker tag doot/jhauschildt:${SNAP_COMMIT_SHORT} doot/jhauschildt:stable
  docker push doot/jhauschildt:stable
  docker push doot/jhauschildt:${SNAP_COMMIT_SHORT}
else
  echo "Not on the master branch, won't deploy..."
fi