docker build -t mfrey777/multi-client:latest -t mfrey777/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mfrey777/multi-server:latest -t mfrey777/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mfrey777/multi-worker:latest -t mfrey777/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push  mfrey777/multi-client:latest
docker push  mfrey777/multi-server:latest
docker push  mfrey777/multi-worker:latest
docker push  mfrey777/multi-client:$SHA
docker push  mfrey777/multi-server:$SHA
docker push  mfrey777/multi-worker:$SHA 
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mfrey777/multi-server:$SHA
kubectl set image deployments/client-deployment client=mfrey777/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mfrey777/multi-worker:$SHA