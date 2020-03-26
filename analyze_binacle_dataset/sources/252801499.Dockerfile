# build for eason02/curator-plus:latest  
FROM eason02/alpine-pip:latest  
  
MAINTAINER Eason Lau <eason.lau02@hotmail.com>  
  
ENV CURATOR_VERSION=5.2.0  
RUN pip install elasticsearch-curator==${CURATOR_VERSION} && \  
curator --version && \  
mkdir /repo  
  
COPY . /repo/  
  
RUN mkdir -p /var/log/curator/ && \  
chmod +x /repo/startcron.sh && \  
ls -ltr /repo  
  
WORKDIR /repo/  
  
CMD ["/repo/startcron.sh"]  

