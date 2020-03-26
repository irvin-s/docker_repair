# Stage: Build  
FROM golang:1.8-alpine as builder  
  
  
ENV VERSION=0.8.0  
RUN set -x \  
&& apk --update add git  
  
RUN set -x \  
&& mkdir -p /go/src \  
&& cd /go/src \  
&& git clone https://github.com/go-graphite/carbonapi.git  
  
# build carbonapi  
WORKDIR /go/src/carbonapi  
RUN git checkout ${VERSION}  
RUN go-wrapper download  
  
RUN go build  
  
# Stage: Run  
FROM alpine  
  
COPY \--from=builder /go/src/carbonapi/carbonapi /sbin/  
  
COPY entrypoint.sh /entrypoint.sh  
COPY carbonapi.yaml /etc/carbonapi.yaml  
  
EXPOSE 8080  
ENTRYPOINT [ "/entrypoint.sh" ]  
CMD [ "/sbin/carbonapi", "-config", "/etc/carbonapi.yaml"]  

