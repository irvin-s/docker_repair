FROM ubuntu:14.04  
MAINTAINER David Siaw <david.siaw@mobingi.com>  
  
ADD provision.sh /provision.sh  
ADD run.sh /run.sh  
ADD api /api  
  
ENV MOCLOUD_STACK_ID unknown  
ENV AWS_ACCESS_KEY_ID accesskey  
ENV AWS_SECRET_ACCESS_KEY secretaccesskey  
ENV AWS_SESSION_TOKEN none  
ENV AWS_REGION us-east-1  
RUN bash /provision.sh  
RUN chmod +x /run.sh  
  
EXPOSE 4567  
CMD ["./run.sh"]  

