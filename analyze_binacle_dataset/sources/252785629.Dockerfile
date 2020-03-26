FROM ubuntu:latest  
  
RUN apt-get update -y && \  
apt-get install -y \  
xvfb \  
python \  
python-pip \  
python-dev \  
gcc && \  
apt-get clean  
  
RUN pip install robotframework psutil robotremoteserver  
  
ENV DISPLAY=0  
ENV SCREEN=0  
ENV DISPLAY_MODE=1024x768x16  
  
EXPOSE 6000  
EXPOSE 8270  
COPY xvfb.sh /usr/local/bin/  
RUN chmod ug+x /usr/local/bin/xvfb.sh  
COPY XvfbControl.py XvfbControl.py  
RUN chmod ug+x XvfbControl.py  
ENTRYPOINT ["/usr/local/bin/xvfb.sh"]  

