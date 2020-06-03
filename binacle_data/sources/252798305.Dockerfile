FROM alpine:3.3  
MAINTAINER Micheal Waltz <mwaltz@demandbase.com>  
  
RUN apk --no-cache add py-pip bash groff && \  
pip install awscli  
  
COPY run.sh .  
  
ENTRYPOINT ["./run.sh"]  

