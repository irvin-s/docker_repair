FROM node:latest
EXPOSE 3000

RUN apt-get update
RUN apt-get install -y build-essential
