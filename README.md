# CogTask
This is to build a complete CI/CD pipeline for flask application using git - Jenkins - Docker

Here are the steps done to achieve it

Based on https://github.com/Sysnove/flask-hello-world project which includes:
 - hello.py  - python code to be deployed
 - requirements.txt  - for the needed packages
 
 A docker file has been uploaded to build the images and containers.
 
docker build -t flask-alpine:latest /home/muhammadbadawy/Downloads/cognitiveTask/flask3
docker run -d -p 5000:5000 --name "ForJenkins" flask-alpine
