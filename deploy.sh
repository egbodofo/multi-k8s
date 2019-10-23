docker build -t egbodofo/multi-client:latest -t egbodofo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t egbodofo/multi-server::latest -t egbodofo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t egbodofo/multi-worker:latest -t egbodofo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push egbodofo/multi-client:latest
docker push egbodofo/multi-server:latest
docker push egbodofo/multi-worker:latest

docker push egbodofo/multi-client:$SHA
docker push egbodofo/multi-server:$SHA
docker push egbodofo/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=egbodofo/multi-server:$SHA
kubectl set image deployments/client-deployment client=egbodofo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=egbodofo/multi-worker:$SHA


# Other Userful Commands
# docker run -it -v "$(pwd)":/usr/src/app ruby:2.3 bash
# gem install travis --no-rdoc --no-ri
# travis login
# travis encrypt-file service-account.json -r egbodofo/multi-docker-k8s
# kubectl set image deployment/client-deployment client=egbodofo/multi-docker-client
# kubectl create secret generic pgpassword --from-literal PGPASSWORD=postgres_password
# kubectl create serviceaccount --namespace kube-system tiller
# kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
# helm init --service-account tiller --upgrade
