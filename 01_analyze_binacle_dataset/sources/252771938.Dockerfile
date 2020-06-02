# SOX audio tool  
#FROM ubuntu:14.04  
#FROM meteorhacks/meteord:base  
#FROM kadirahq/meteord:base  
FROM abernix/meteord:base  
MAINTAINER Philipp Fauser <philipp@attic-studio.net>  
RUN apt-get update  
  
# install ffmpeg  
RUN apt-get install -y libav-tools  
RUN ln -s /usr/bin/avconv /usr/bin/ffmpeg  
  
# install sox and mp3 codec  
RUN apt-get install -y sox  
RUN apt-get install -y libsox-fmt-mp3  
RUN apt-get install -y curl  
  
# create folders  
RUN mkdir /opt/files  
  
# get audio logo  
RUN curl http://files.noisefarm.net/files/logo.mp3 > /opt/files/logo.mp3  
RUN ls -la  
  
# change permissions  
RUN chmod a+wx /opt  
RUN chmod a+wx /opt/files  
RUN chmod a+wx /opt/files/logo.mp3  
  
# install ID3 tag python lib  
RUN apt-get install -y python-pip  
RUN pip install mutagen

