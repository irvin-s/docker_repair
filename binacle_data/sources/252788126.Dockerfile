FROM python  
MAINTAINER CREATIVE AREA  
RUN pip install awscli  
VOLUME /root/.aws  
ENTRYPOINT ["aws"]  

