FROM python:3.6-alpine3.7  
ARG BORGMATIC_VERSION=1.1.15  
RUN apk --no-cache add borgbackup openssh-client  
RUN pip3 install borgmatic==$BORGMATIC_VERSION  
CMD ["borgmatic"]  

