FROM python:3.5  
MAINTAINER Jan Philip Bernius <janphilip@bernius.net>  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
groff \  
&& rm -rf /var/lib/apt/lists/*  
RUN pip install awscli  
RUN aws --version  
  
RUN mkdir -p /root/data  
WORKDIR /root/data  
VOLUME ["/root/.aws"]  
  
ENTRYPOINT ["aws"]  
CMD ["help"]

