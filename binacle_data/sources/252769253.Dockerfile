FROM anibali/alpine-tini:3.2  
  
RUN mkdir -p /go/src /go/bin  
ENV GOPATH /go  
ENV PATH /go/bin:$PATH  
  
ENV DOCKERGEN_GIT_TAG=0.4.3  
  
RUN apk add \--update curl git go \  
&& mkdir -p /usr/src/docker-gen \  
&& git clone https://github.com/jwilder/docker-gen.git /usr/src/docker-gen \  
&& cd /usr/src/docker-gen \  
&& git checkout tags/$DOCKERGEN_GIT_TAG \  
&& go get github.com/robfig/glock \  
&& glock sync -n < GLOCKFILE \  
&& go build -ldflags "-X main.buildVersion=$DOCKERGEN_GIT_TAG" \  
&& cp /usr/src/docker-gen/docker-gen /usr/bin \  
&& rm -rf /usr/src/docker-gen \  
&& rm -rf /go \  
&& apk del curl git go \  
&& rm -rf /var/cache/apk/*  
  
CMD ["docker-gen"]  

