## Task 1 - Dockerize the application

### Approach
We will be using docker compose utility from docker to containerize the application. Our approach will be to have 3 separate containers, one each for
- backend (Flask API)
- frontend (Node React)
- server (nginx)
 
 I will try to compile the flow in a simple way to understand. 

First, we are creating a Dockerfile for the backend (under api directory) which will run the API app through flask. We are using official base python3 image (from dockerhub). We will be running the `pip` command to install all python dependencies. Later, we will be running Gunicorn to serve our flask application, hence preparing our application-server.

Secondly, we will be creating a Dockerfile for Nginx to host our application on web. Along with this, we will be having a nginx.conf to override the default configuration.

As frontend is being built using React, we will be creating a third Dockerfile (under sys-stats directory) using node image to build the app. This react build will be served with an Nginx server and hence making up our web-server.

All HTTP requests to our web-server will be forwarded to the application-server via reverse-proxy with Nginx. 

### Details

Nginx:
- We have to take care of adding a CORS header to nginx.conf file for handling CORS requests.

Frontend:
- We need to keep running the react app for handling auto-build request. The Dockerfile of frontend is taking care of this requirement by adding the required additional package for auto-build.

Backend:
- We need to add all the required python dependencies to the requirements.txt file. The Dockerfile for backend should expose the port for the web server to make requests.

Docker-compose.yaml:
- We need to share the volume between frontend and the nginx server to allow web server to render the built app.
- Sequence of service is important as web server can only render the app after the frontend is built. Therefore, the dependency of the web server should be taken care.
- Node ports should be exposed to allow the access of the app from user's machine

### Prerequisites:=
- docker-compose
- docker

### Deployment
Run the docker compose command being in the top level directory where `docker-compose.yml` is present.
```bash
docker-compose up --build 
```