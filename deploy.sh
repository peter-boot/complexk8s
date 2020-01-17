docker build -t peterboot/multi-client:latest -t peterboot/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t peterboot/multi-server:latest -t peterboot/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t peterboot/multi-worker:latest -t peterboot/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push peterboot/multi-client:latest
docker push peterboot/multi-server:latest
docker push peterboot/multi-worker:latest

docker push peterboot/multi-client:$SHA
docker push peterboot/multi-server:$SHA
docker push peterboot/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=peterboot/multi-server:$SHA
kubectl set image deployments/client-deployment client=peterboot/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=peterboot/multi-worker:$SHA