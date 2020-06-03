# Creates a Docker image for running the service.  
ARG name=echoudp  
ARG src=github.com/alcortesm/echoudp  
ARG bin=/bin/${name}  
ARG healthcheck=/bin/healthcheck  
  
####  
# Creates a Docker image with the sources.  
FROM golang:1.10.2-alpine3.7 AS src  
ARG src  
  
# Copy the sources.  
COPY . /go/src/${src}  
  
####  
# Creates a Docker image with a static binary of the service.  
FROM src as build  
ARG bin  
ARG name  
ARG src  
ARG healthcheck  
WORKDIR /go/src/${src}  
RUN CGO_ENABLED=0 go build \  
-o ${healthcheck} \  
-ldflags '-extldflags "-static"' \  
./cmd/healthcheck  
RUN CGO_ENABLED=0 go build \  
-o ${bin} \  
-ldflags '-extldflags "-static"' \  
./cmd/${name}  
  
####  
# Creates a single layer image to run the service.  
FROM scratch as run  
ARG bin  
ARG healthcheck  
COPY \--from=build ${healthcheck} /bin/healthcheck  
COPY \--from=build ${bin} /bin/service  
ENTRYPOINT ["/bin/service"]  

