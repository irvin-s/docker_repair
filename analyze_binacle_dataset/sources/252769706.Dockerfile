FROM alpine:3.2  
RUN mkdir -p /aws  
RUN apk --update-cache --verbose add wget python py-pip  
RUN pip install awscli  
RUN apk --purge -v del py-pip  
RUN rm /var/cache/apk/*  
  
WORKDIR /aws  
  

