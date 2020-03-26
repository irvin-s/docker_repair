FROM google/cloud-sdk:alpine  
RUN apk --update add bash  
COPY bin/deployment-manager.sh /deployment-manager.sh  
ENTRYPOINT /deployment-manager.sh

