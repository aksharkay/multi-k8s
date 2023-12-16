docker build -t aksharkay/multi-client:latest -t aksharkay/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t aksharkay/multi-server:latest -t aksharkay/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t aksharkay/multi-worker:latest -t aksharkay/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push aksharkay/multi-client:latest
docker push aksharkay/multi-server:latest
docker push aksharkay/multi-worker:latest

docker push aksharkay/multi-client:$SHA
docker push aksharkay/multi-server:$SHA
docker push aksharkay/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=aksharkay/multi-server:$SHA
kubectl set image deployments/client-deployment client=aksharkay/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aksharkay/multi-worker:$SHA