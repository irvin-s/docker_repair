FROM alpine:3.6  
MAINTAINER Yaroslav Admin "yaroslav.admin@softwerk.se"  
RUN apk add --no-cache python3 && \  
python3 -m ensurepip && \  
rm -r /usr/lib/python*/ensurepip && \  
pip3 install --upgrade pip setuptools && \  
rm -r /root/.cache  
  
RUN pip3 install mkdocs==0.16.3  
  
WORKDIR /srv/docs  
  
EXPOSE 8000  
CMD ["mkdocs", "serve", "-a", "0.0.0.0:8000"]  

