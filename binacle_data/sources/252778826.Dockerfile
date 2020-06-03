FROM progrium/busybox  
MAINTAINER Jeff Lindsay <progrium@gmail.com>  
  
ADD https://get.docker.io/builds/Linux/x86_64/docker-latest /bin/docker  
RUN chmod +x /bin/docker  
  
ADD ./builder /tmp/builder  
  
USER nobody  
ENV DOCKER unix:///tmp/docker.sock  
ENTRYPOINT ["/tmp/builder/build"]

