docker build -t zygimantus/multi-client:latest -t zygimantus/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t zygimantus/multi-server:latest -t zygimantus/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t zygimantus/multi-worker:latest -t zygimantus/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push zygimantus/multi-client:latest
docker push zygimantus/multi-server:latest
docker push zygimantus/multi-worker:latest

docker push zygimantus/multi-client:$SHA
docker push zygimantus/multi-server:$SHA
docker push zygimantus/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=zygimantus/multi-server:$SHA
kubectl set image deployments/client-deployment client=zygimantus/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=zygimantus/multi-worker:$SHA