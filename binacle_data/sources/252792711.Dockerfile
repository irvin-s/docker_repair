FROM alpine:edge  
MAINTAINER Daniel Guerra  
RUN apk -U add tor torsocks  
EXPOSE 9050 53/udp  
ADD bin /bin  
ADD etc /etc  
CMD /bin/start.sh  

