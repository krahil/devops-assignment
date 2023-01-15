## Task 3 - Deploying application on Kubernetes
For deploying the application on kubernetes, we already have most of the components ready with us from Task #1 while dockerizing the application. Since Kubernetes is an orchestration tool, it will help us to easily manage the application after its deployment.
### Approach
We will be creating a deployment for the application for `high availability`. For this we will be creating two configuration files, one for backend and the other for frontend. These configuration files will be describing the deployment and service objects.

Generally, a production application requires high availability for which the best practice is to have a deployment in kubernetes. Deployment rolls out the application again in case of any failure, thus providing high availability.

Here, we are utilizing docker images we had created during Task #1. These images will be used in the deployments. There are two deployments:
- first one for backend which will be running the flask application and serving through Gunicorn.
- second for frontend that is build using React and hosted using Nginx.

We have tried creating the service in the same config file as the services are related to respective deployments.
Frontend service will be a `Load Balancer` service as it has to serve user's request whereas, backend service can be a `NodePort` type service. Default is a `ClusterIp` service.

We have set the port as `80` on the frontend service to allow accessing the app using the same port. An `External IP` will be generated in frontend service. Once the IP is available, user will be able to access the web applicaiton on port 80.

### Prerequisites
- minikube
- kubectl

### Deployment
First start the minikube cluster using following command:
```bash
minikube start
```
Above command will start a development kubernetes cluster with one worker node.
Chnage the directory to `kubernetes` and run the deployment as follows:
```bash
cd kubernetes
kubectl apply -f frontend.yaml
kubectl apply -f backend.yaml
```
