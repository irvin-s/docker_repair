# Docker file to run Elasticsearch Curator.  
FROM gliderlabs/alpine:3.4  
MAINTAINER Stuart Wong <cgs.wong@gmail.com>  
  
ENV CURATOR_VERSION 3.2.0  
RUN apk --no-cache add \  
python \  
py-pip &&\  
pip install --upgrade pip &&\  
pip install elasticsearch-curator==${CURATOR_VERSION}  
  
ENTRYPOINT ["/usr/bin/curator"]  
CMD [""]  

