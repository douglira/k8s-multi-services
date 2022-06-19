docker build -f /client/Dockerfile -t douglira/multi-webapp:latest -t douglira/multi-webapp:${SHA} ./client
docker build -f /server/Dockerfile -t douglira/multi-server:latest -t douglira/multi-server:${SHA} ./server
docker build -f /worker/Dockerfile -t douglira/multi-worker:latest -t douglira/multi-worker:${SHA} ./worker

docker push douglira/multi-webapp:latest
docker push douglira/multi-server:latest
docker push douglira/multi-worker:latest

docker push douglira/multi-webapp:${SHA}
docker push douglira/multi-server:${SHA}
docker push douglira/multi-worker:${SHA}

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=douglira/multi-webapp:${SHA}
kubectl set image deployments/server-deployment server=douglira/multi-server:${SHA}
kubectl set image deployments/worker-deployment worker=douglira/multi-worker:${SHA}