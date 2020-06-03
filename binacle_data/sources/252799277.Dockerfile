FROM gliderlabs/alpine  
  
RUN apk add --update python3 && \  
rm /var/cache/apk/*  
  
RUN pip3 install awscli  
  
RUN aws configure set preview.cloudfront true  
  
ENTRYPOINT ["aws"]

