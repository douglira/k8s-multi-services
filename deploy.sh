#!/bin/bash

echo "COMMIT SHA $SHA"
echo "TAVIS COMMIT $TRAVIS_COMMIT"

docker build -f /client/Dockerfile -t douglira/multi-webapp:latest -t douglira/multi-webapp:$TRAVIS_COMMIT ./client
docker build -f /server/Dockerfile -t douglira/multi-server:latest -t douglira/multi-server:$TRAVIS_COMMIT ./server
docker build -f /worker/Dockerfile -t douglira/multi-worker:latest -t douglira/multi-worker:$TRAVIS_COMMIT ./worker

docker push douglira/multi-webapp:latest
docker push douglira/multi-server:latest
docker push douglira/multi-worker:latest

docker push douglira/multi-webapp:$TRAVIS_COMMIT
docker push douglira/multi-server:$TRAVIS_COMMIT
docker push douglira/multi-worker:$TRAVIS_COMMIT

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=douglira/multi-webapp:$TRAVIS_COMMIT
kubectl set image deployments/server-deployment server=douglira/multi-server:$TRAVIS_COMMIT
kubectl set image deployments/worker-deployment worker=douglira/multi-worker:$TRAVIS_COMMIT