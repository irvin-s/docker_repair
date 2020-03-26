FROM python:2  
RUN pip install awscli  
VOLUME /root/.aws  
ENTRYPOINT ["aws"]  

