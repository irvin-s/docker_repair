FROM google/golang  
  
ENV DOCKER_HOST unix:///var/run/docker.sock  
  
RUN go get github.com/fsouza/go-dockerclient  
RUN go get -v github.com/dogestry/dogestry/dogestry  
  
CMD []

