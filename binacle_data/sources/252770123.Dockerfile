FROM golang:alpine  
  
COPY . /mnt  
  
RUN set -x \  
&& apk add --no-cache git \  
&& cd /mnt \  
&& go get -d -v \  
&& go build listcompute.go \  
&& mv ./listcompute /bin/listcompute \  
&& apk del git  
  
CMD ["listcompute"]  

