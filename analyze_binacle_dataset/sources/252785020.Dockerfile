FROM alpine:latest  
  
RUN apk add --no-cache curl jq  
  
ENV VERSION v1.6.3  
RUN curl -o /usr/local/bin/kubectl \  
-L https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/linux/amd64/kubectl  
  
RUN chmod +x /usr/local/bin/kubectl  
  
COPY assets/ /opt/resource/  
  
RUN chmod +x /opt/resource/in && chmod +x /opt/resource/out  

