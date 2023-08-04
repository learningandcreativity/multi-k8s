docker build -t pkhot/multi-client:latest -t pkhot/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pkhot/multi-server:latest -t pkhot/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pkhot/multi-worker:latest -t pkhot/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push pkhot/multi-client:latest
docker push pkhot/multi-server:latest
docker push pkhot/multi-worker:latest

docker push pkhot/multi-client:$SHA
docker push pkhot/multi-server:$SHA
docker push pkhot/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pkhot-multi-server:$SHA
kubectl set image deployments/client-deployment server=pkhot-multi-client:$SHA
kubectl set image deployments/worker-deployment server=pkhot-multi-worker:$SHA

