FROM alpine  
RUN apk update  
RUN apk add sqlite  
RUN apk add kamailio  
RUN apk add kamailio-sqlite  
RUN apk update && apk add vim nano bash  
ADD start-server.sh start-server.sh  
#CMD start-server.sh  

