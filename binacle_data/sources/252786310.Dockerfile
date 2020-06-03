FROM alpine  
RUN apk --no-cache update \  
&& apk --no-cache upgrade \  
&& apk add openssh  
RUN ssh-keygen -A  
RUN mkdir /root/.ssh  
WORKDIR /root  
COPY docker-agent ./  
VOLUME ["/tmp"]  
EXPOSE 22  
CMD ["cat", "docker-agent"]  

