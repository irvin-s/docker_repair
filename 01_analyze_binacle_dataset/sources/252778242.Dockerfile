FROM google/cloud-sdk:alpine  
LABEL maintainer "Appverse <publish@appverse.io>"  
COPY backup.sh .  
ENTRYPOINT ./backup.sh  

