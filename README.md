Flask Hello World application
=============================
This is to build complete CI/CD for flask application using git - Jenkins - Docker.

Required Software:
------------------
- git
- jenkins
- docker
- docker-compose
- python 2.7 or above
- Linux OS - (We used ubuntu 14.04 64bit)

What is Done:
-------------
 - Dockerfile for your application and any other needed component.
 - Uploading image to docker registry.
 - Docker Compose to run docker containers.
 - Jenkins job "steps" to achieve the CI/CD.
 - Deploying the containers on Docker swarm


---------
Let's go:
---------

Based on `https://github.com/Sysnove/flask-hello-world` project which includes:
 - hello.py  -- python code to be deployed
 - requirements.txt  -- required packages to be deployed

We added:
 A docker file has been defined to build image and run containers
 A docker compose file has been defined to run containers as a service
 Steps to run the application through containers.
 How to use Jenkins to  for CI/CD


make sure that you have git, docker, Jenkins installed on your machine

------
Steps:
------
$mkdir flaskweb
$git init
$git pull https://github.com/Badawekoo/CogTask

So you have now what you need to build image and run containers
Run the below command which will read from Dockerfile and follow the instrctions inside 
$docker build -t flask-alpine:latest .

Now the image should be created successfully
To check the image:
$docker image ls

You should see something like this:
REPOSITORY             TAG                 IMAGE ID            CREATED             SIZE
flask-alpine           latest              76d30c4fec45        17 hours ago        88MB

Now we are ready to run container based on that image:

$docker run -d -p 5000:5000 --name "pyhtonapp01" flask-alpine
To check the container:

$docker container ls

You should see something like this:

CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                    NAMES
e09a43f77bd0        flask-alpine        "python hello.py"   26 seconds ago      Up 6 seconds        0.0.0.0:5000->5000/tcp   pyhtonapp01

Now go to your browser and hit localhost:5000, you should see your application deployed.

-------------------------------------
To push/pull the image to docker registry:
-------------------------------------
$docker tag 76d30c4fec45 badawekoo/flask-alpine:task
$docker push badawekoo/flask-alpine:task

output:
The push refers to repository [docker.io/badawekoo/flask-alpine]
6664852d10f2: Pushed 
d17f25cb3086: Pushed 
ec86574ae10e: Pushed 
4a2596f9aa79: Mounted from library/python 
5cf3066ccdbc: Mounted from library/python 
76a1661c28fc: Mounted from library/python 
beefb6beb20f: Mounted from library/python 
df64d3292fd6: Mounted from library/python 
task: digest: sha256:53ac9a0eb21b6de93f8e68e699ad68f3c69ccffd8dd7622311b94f917a8056da size: 1995

## to pull the image
$docker pull badawekoo/flask-alpine:task

------------------------------------------------------
To run the container as a service from docker compose:
------------------------------------------------------

Place "docker-compose.yml" to the parent directory of the project
Then
$docker-compose up

Now out app should be running through localhost:5000

Note: docker-compose.yml file looks like below:
flask:
  build: ./flask
  ports:
   - "5000:5000"
  volumes:
   - .:/code 

Where flask is the parent directory name of project directory 

----------------------------------
To apply this through jenkins job:
----------------------------------

Login to Jenkins
Go to New Item --> Free Style project "enter a valid name for the project"
Then Source Code Managment tab --> Choose Git --> Enter the URL for git repo - https://github.com/Badawekoo/CogTask
Make sure that branch is master
Then build tab --> Execute shell --> add the following commands to be executed

docker build -t flask-alpine:latest PATH/TO/PROJECT
docker run -d -p 5000:5000 --name "pyhtonapp01" flask-alpine

Press Save and then Build now to deploy the application
Note before we build we need to add jenkins user to docker group to execute docker commands:

$gpasswd -aG jenkins docker

After job finished successfully, app should be running through localhost:5000

-----------------------------------------------------
To run/deploy/scale the conatainer through docker swarm
-----------------------------------------------------
#To let the current node the manager node
$docker swarm init

#To deploy a container based on an existing image
$docker service create --name Image_Name -p 80:80 EXISTING_IMAGE 

#To check the running service
$docker service ls

#To scale the number of running containers
$docker service scale SERIVCE_NAME=3
