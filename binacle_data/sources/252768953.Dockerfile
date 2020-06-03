# Run pulseaudio server in a container  
#  
# TODO  
# - reset volume to 80% and keep it enabled when the container runs  
#  
FROM debian:jessie  
MAINTAINER Andrey Arapov <andrey.arapov@nixaid.com>  
# Inspired by Jessica Frazelle <jess@docker.com>  
# To avoid problems with Dialog and curses wizards  
ENV DEBIAN_FRONTEND noninteractive  
  
# Define a user under which the pulseaudio server will be running  
ENV USER pulseaudio  
ENV UID 1000  
ENV GROUPS audio  
ENV HOME /home/$USER  
RUN apt-get update \  
&& apt-get install -yq pulseaudio pulseaudio-module-x11 \  
&& rm -rf /var/lib/apt/lists  
  
COPY [ "default.pa", "client.conf", "daemon.conf", "/etc/pulse/" ]  
  
RUN useradd -u $UID -m -d $HOME -s /usr/sbin/nologin $USER \  
&& usermod -aG $GROUPS $USER \  
&& chmod 0644 -- /etc/pulse/* \  
&& mkdir -p $HOME/.config/pulse \  
&& chown -Rh $USER:$USER \-- $HOME  
  
WORKDIR $HOME  
USER $USER  
VOLUME [ "/tmp", "$HOME/.config/pulse" ]  
ENTRYPOINT [ "/usr/bin/pulseaudio" ]  

