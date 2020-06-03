# Dockerfile to run the JKA demo site syncer  
FROM ubuntu:16.04  
MAINTAINER Dan Padgett <dumbledore3@gmail.com>  
  
RUN apt-get update  
RUN apt-get install -y \  
lftp \  
rsync \  
ssh \  
curl  
  
RUN useradd -ms /bin/bash syncer  
  
# copy the nice dotfiles that dockerfile/ubuntu gives us:  
RUN cd && cp -R .bashrc .profile /home/syncer  
  
WORKDIR /home/syncer  
  
COPY scripts/* ./  
  
RUN chown -R syncer:syncer /home/syncer  
  
USER syncer  
ENV HOME /home/syncer  
ENV USER syncer  
  
CMD /home/syncer/syncer.sh  

