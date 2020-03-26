FROM golang:1.7-alpine  
  
RUN apk update \  
&& apk add ca-certificates wget git openssh \  
&& update-ca-certificates  
  
ENV CONFIG_FILE=/etc/git-repo-mirror/config.yml  
  
# Copy the local package files to the container's workspace.  
ADD . /go/src/github.com/benjamincaldwell/git-repo-mirror  
WORKDIR /go/src/github.com/benjamincaldwell/git-repo-mirror  
  
# Install glide  
RUN wget -qO- https://glide.sh/get | sh  
  
RUN glide install  
  
RUN go install github.com/benjamincaldwell/git-repo-mirror  
  
RUN mkdir /etc/git-repo-mirror; echo "---" > /etc/git-repo-mirror/config.yml  
  
# Run the outyet command by default when the container starts.  
ENTRYPOINT /go/bin/git-repo-mirror  
  
# Document that the service listens on port 8080.  
EXPOSE 8080  

