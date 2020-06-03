FROM golang:1.8-alpine  
  
COPY . /opt/zookeeper_exporter  
  
RUN set -x \  
&& apk add --no-cache git \  
&& cd /opt/zookeeper_exporter \  
&& go get -d \  
&& go build \  
&& mv /opt/zookeeper_exporter/zookeeper_exporter /usr/local/bin \  
&& chmod +x /usr/local/bin/zookeeper_exporter \  
&& rm -fr /opt/zookeeper_exporter /go  
  
EXPOSE 9114  
ENTRYPOINT ["/usr/local/bin/zookeeper_exporter"]  

