FROM golang:latest as builder  
ADD build.sh /  
RUN /build.sh  
  
FROM alpine:latest  
ENV TZ=Asia/Shanghai  
ADD runner.sh /  
RUN /runner.sh  
COPY \--from=builder /usr/bin/v2ray /usr/bin/v2ray  
ENV PATH /usr/bin/v2ray/:$PATH  
CMD ["/usr/bin/v2ray/v2ray", "-config=/etc/v2ray/config.json"]  

