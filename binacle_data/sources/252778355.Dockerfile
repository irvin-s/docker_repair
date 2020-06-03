FROM ethereum/client-go:alpine  
  
RUN apk add --update bash ca-certificates  
ADD health.sh /health.sh  
ADD readiness.sh /readiness.sh  
RUN chmod a+x /*.sh  

