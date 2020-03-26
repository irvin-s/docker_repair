FROM golang:latest AS build  
WORKDIR /src  
ENV LAST_UPDATE=20180419  
ADD . /src  
RUN go get -d -v -t  
RUN go test \--cover ./...  
RUN go build -v -tags netgo -o cicd-util  
  
FROM alpine:3.6  
ENV LAST_UPDATE=20171210  
ENV DOCKER_API_VERSION=1.35  
ENV TEMPLATE_ROOT="/srv/"  
ENV EXTERNAL_HOSTNAME=""  
LABEL authors="Joost van der Griendt <joostvdg@gmail.com>"  
LABEL version="0.1.0"  
LABEL description="Docker image for CICD Sandbox Util"  
CMD ["cicd-util"]  
COPY \--from=build /src/cicd-util /usr/local/bin/cicd-util  
COPY index.html /srv/  
RUN chmod +x /usr/local/bin/cicd-util  

