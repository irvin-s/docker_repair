FROM ubuntu:14.10
MAINTAINER Nikita Shmakov <nikshmakov@gmail.com>
RUN apt-get update && apt-get install -y python
COPY site/ /usr/share/example-docker-app/site/
WORKDIR /usr/share/example-docker-app/site/
CMD python -m SimpleHTTPServer 5000
EXPOSE 5000
