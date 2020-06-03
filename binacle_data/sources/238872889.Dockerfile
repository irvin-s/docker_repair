FROM ubuntu:16.04
MAINTAINER Jacob <chenjr0719@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV USER ubuntu
ENV HOME /home/$USER

# Create new user for vnc login.
RUN adduser $USER --disabled-password

# Install MATE and dependency component.
RUN apt-get update \
    && apt-get install -y \
        tightvncserver \
        mate-core mate-desktop-environment mate-notification-daemon \
        supervisor \
        net-tools \
        curl \
        git \
        pwgen \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# Clone noVNC.
RUN git clone https://github.com/novnc/noVNC.git $HOME/noVNC

# Clone websockify for noVNC
Run git clone https://github.com/kanaka/websockify $HOME/noVNC/utils/websockify

# Download ngrok.
ADD https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip $HOME/ngrok/ngrok.zip
RUN unzip -o $HOME/ngrok/ngrok.zip -d $HOME/ngrok && rm $HOME/ngrok/ngrok.zip

# Copy supervisor config.
COPY supervisor.conf /etc/supervisor/conf.d/

# Copy startup script.
COPY startup.sh $HOME

EXPOSE 6080 5901 4040
CMD ["/bin/bash", "/home/ubuntu/startup.sh"]
