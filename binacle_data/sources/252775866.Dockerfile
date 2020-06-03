FROM golang:1.10.1-alpine3.7  
ARG WORK_PATH=/home/src  
ARG GO_PATH=/home/GOPATH  
ARG TARGET=$GO_PATH/src/targetProject  
ARG CACHE_DIR=/home/cache  
ARG CONFIG_DIR=/root/.glide  
  
  
COPY ./build.sh /usr/bin/build  
  
RUN apk update \  
&& apk add --no-cache ca-certificates git gcc musl-dev \  
&& go get -u github.com/Masterminds/glide \  
&& chmod +x /usr/bin/build \  
&& mkdir -p $WORK_PATH "$GO_PATH/src" $TARGE $CACHE_DIR $CONFIG_DIR \  
&& ln -s $WORK_PATH $TARGET \  
&& ln -s $CACHE_DIR "$CONFIG_DIR/cache"  
  
WORKDIR $WORK_PATH  
  
ENV GOPATH=$GO_PATH  
  
  
VOLUME $CACHE_DIR  
  
CMD ["build"]

