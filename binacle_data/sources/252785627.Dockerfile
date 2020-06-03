FROM ubuntu:latest  
  
RUN apt-get update -y && apt-get install -y \  
ffmpeg \  
python \  
python-pip \  
python-dev \  
gcc && \  
apt-get clean  
  
RUN pip install robotframework psutil robotremoteserver  
  
ENV DISPLAY=0  
ENV CAPTUREFILE=video.mpg  
ENV DISPLAY_SIZE=1024x768  
  
EXPOSE 8270  
VOLUME /capture  
  
COPY ffmpeg.sh /usr/local/bin/  
RUN chmod ug+x /usr/local/bin/ffmpeg.sh  
COPY FfmpegControl.py FfmpegControl.py  
RUN chmod ug+x FfmpegControl.py  
ENTRYPOINT ["/usr/local/bin/ffmpeg.sh"]  
  

