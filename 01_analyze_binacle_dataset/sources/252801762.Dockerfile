FROM scratch  
MAINTAINER Corey Butler  
  
ENV AWS_KEY none  
ENV AWS_SECRET none  
ENV AWS_BUCKET none  
ENV AWS_REGION us-west-1  
ADD ./lib /scripts/aws/s3  
  
VOLUME /scripts/aws/s3  

