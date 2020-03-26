FROM cogumbreiro/hj-why3-base  
  
MAINTAINER Tiago Cogumbreiro  
  
USER root  
  
RUN apt-get update && apt-get install -y \  
x11vnc \  
python \  
python-numpy \  
unzip \  
Xvfb \  
net-tools \  
xinit \  
git  
  
ENV PORT 8080  
ENV DISPLAY :0  
ADD docker/startup.sh /usr/local/bin/check  
ADD docker/xinitrc /home/$USER/.xinitrc  
ADD docker/launch.patch /home/$USER/launch.patch  
ADD docker/why3.conf /home/$USER/ide.conf  
  
RUN chmod a+x /usr/local/bin/check  
  
USER $USER  
RUN cd ~ && git clone https://github.com/kanaka/noVNC && \  
cd noVNC/utils && git clone https://github.com/kanaka/websockify && \  
ln -s ~/noVNC/vnc_auto.html ~/noVNC/index.html && \  
(cd ~/noVNC; patch utils/launch.sh < ~/launch.patch) && \  
cat ~/ide.conf >> ~/.why3.conf  
  
EXPOSE $PORT  

