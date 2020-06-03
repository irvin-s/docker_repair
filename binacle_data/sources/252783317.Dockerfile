# ffmpeg live transcoder  
#  
# VERSION 2.4.3  
#  
# From https://trac.ffmpeg.org/wiki/CompilationGuide/Centos  
#  
FROM jrottenberg/ffmpeg:2.4.3  
MAINTAINER Dragos Dascalita Haut <ddragosd@gmail.com>  
  
RUN yum install -y python-configobj python-urllib2 python-argparse  
COPY live_transcoder.py /usr/local/live-transcoder/  
COPY default_config.json /etc/live-transcoder/  
RUN mkdir -p /var/log/streamkit/  
  
# forward request and error logs to docker log collector  
RUN ln -sf /dev/stdout /var/log/streamkit/*  
  
VOLUME /var/log/streamkit/  
  
ENTRYPOINT ["python", "/usr/local/live-transcoder/live_transcoder.py"]  

