FROM ubuntu  
MAINTAINER Christian Lück <christian@lueck.tv>  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \  
openssh-client  
  
ENV PORT 0  
  
# only expose default vboxwebsrv port  
EXPOSE 18083  
  
# use run.sh help to check parameters and connect to target  
ADD run.sh run.sh  
ENTRYPOINT ["./run.sh"]  
  

