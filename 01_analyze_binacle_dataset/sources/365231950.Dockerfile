FROM 		ubuntu:latest

MAINTAINER 	Dan Wahlin

# Update the repository and install Redis Server
RUN         apt-get update && apt-get install -y redis-server

EXPOSE      6379

ENTRYPOINT  ["/usr/bin/redis-server"]

# To build:
# docker build -f Dockerfile-redis --tag danwahlin/redis .

# To run:
# docker run -d -p 6379:6379 --name redis danwahlin/redis