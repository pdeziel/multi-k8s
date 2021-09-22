docker build -t pdeziel/multi-client:latest -t pdeziel/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pdeziel/multi-server:latest -t pdeziel/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pdeziel/multi-worker:latest -t pdeziel/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pdeziel/multi-client:latest
docker push pdeziel/multi-client:$SHA

docker push pdeziel/multi-server:latest
docker push pdeziel/multi-server:$SHA

docker push pdeziel/multi-worker:latest
docker push pdeziel/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pdeziel/multi-server:$SHA
kubectl set image deployments/client-deployment client=pdeziel/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pdeziel/multi-worker:$SHA