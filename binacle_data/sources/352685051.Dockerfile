FROM ubuntu:18.04

# Use the following two lines to install the Teradici repository package
RUN apt-get update && apt-get install -y wget
RUN wget -O teradici-repo-latest.deb https://downloads.teradici.com/ubuntu/teradici-repo-bionic-latest.deb
RUN apt install ./teradici-repo-latest.deb

# Uncomment the following line to install Beta client builds from the internal repository
#RUN echo "deb [arch=amd64] https://downloads.teradici.com/ubuntu bionic-beta non-free" > /etc/apt/sources.list.d/pcoip.list

# Install apt-transport-https to support the client installation
RUN apt-get update && apt-get install -y apt-transport-https

# Install the client application
RUN apt-get install -y pcoip-client

# Install pulseaudio
RUN apt-get install -y pulseaudio

# Setup a functional user within the docker container with the same permissions as your local user.
# Replace 1000 with your user / group id
# Replace myuser with your local username
RUN export uid=1000 gid=1000 && \
    mkdir -p /etc/sudoers.d/ && \
    mkdir -p /home/myuser && \
    echo "myuser:x:${uid}:${gid}:Myuser,,,:/home/myuser:/bin/bash" >> /etc/passwd && \
    echo "myuser:x:${uid}:" >> /etc/group && \
    echo "myuser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/myuser && \
    chmod 0440 /etc/sudoers.d/myuser && \
    chown ${uid}:${gid} -R /home/myuser

# Set some environment variables for the current user
USER myuser
ENV HOME /home/myuser

# Set the path for QT to find the keyboard context
ENV QT_XKB_CONFIG_ROOT /user/share/X11/xkb

ENTRYPOINT exec pcoip-client
