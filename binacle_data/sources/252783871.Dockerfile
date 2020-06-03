FROM progrium/busybox  
MAINTAINER Kai Davenport <kaiyadavenport@gmail.com>  
  
ADD ./stage/fleetstreet /bin/fleetstreet  
  
ENV DOCKER_HOST unix:///tmp/docker.sock  
  
ENTRYPOINT ["/bin/fleetstreet"]

