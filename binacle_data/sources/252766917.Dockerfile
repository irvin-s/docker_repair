#  
#  
# docker run -v /tmp/.X11-unix:/tmp/.X11-unix \  
# -v $HOME/.Banshee:/home/banshee/.Banshee \  
# -e DISPLAY=unix$DISPLAY \  
# --link pulseaudio:pulseaudio \  
# -e PULSE_SERVER=pulseaudio \  
# --device /dev/video0 \  
# --name banshee \  
# albertalvarezbruned/banshee  
# maybe -v /dev/snd:/dev/snd  
#  
FROM debian:jessie  
  
# Tell debconf to run in non-interactive mode  
ENV DEBIAN_FRONTEND noninteractive  
  
  
# Make sure the repository information is up to date  
RUN dpkg --add-architecture i386 && \  
apt-get update && apt-get install -y \  
ca-certificates \  
curl \  
\--no-install-recommends  
  
# Install banshee  
RUN apt-get install banshee -fy \  
&& rm -rf /var/lib/apt/lists/*  
  
# Make a user  
ENV HOME /home/banshee  
RUN useradd --create-home --home-dir $HOME banshee \  
&& chown -R banshee:banshee $HOME \  
&& usermod -a -G audio,video banshee  
  
WORKDIR $HOME  
USER banshee  
  
# Start banshee  
ENTRYPOINT ["banshee"]  

