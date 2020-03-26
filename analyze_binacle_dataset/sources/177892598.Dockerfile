FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

ARG ARG_UID
ARG ARG_GID

ADD cfgs/supervisord.conf /etc/supervisord.conf

RUN apt-get update && \
    apt-get upgrade -y && \
    \
    echo "Europe/Ljubljana" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    /bin/bash -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf' && \
    \
    apt-get install -y pwgen python-setuptools && \
    easy_install supervisor

# http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/
RUN apt-get install -y x11-apps  && \
# Replace with your user / group id
    export uid=$ARG_UID gid=$ARG_GID && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer && \
    /bin/bash -c "echo 'developer:developerpw' | chpasswd" && \
    usermod -a -G video developer && \
    usermod -a -G audio developer && \
# ssh https://docs.docker.com/examples/running_ssh_service/
#   and SSH login fix. Otherwise user is kicked off after login
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd

# opencv dependencies
RUN apt-get install -y libc6-i386 && \
    apt-get install -y lib32stdc++6 lib32z1 lib32ncurses5 lib32bz2-1.0 && \
    apt-get install -y libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1  && \
    apt-get install -y usbutils && \
    apt-get install -y unzip && \
    apt-get install -y g++ git beep && \
# compiling opencv
    apt-get install -y build-essential cmake libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev v4l2ucp v4l-utils libv4l-dev && \
# utilities - google test
    apt-get install -y libgtest-dev wget && \
    wget https://github.com/Itseez/opencv/archive/2.4.10.4.zip -O /2.4.10.4.zip && \
    bash -c "echo /usr/local/lib >> /etc/ld.so.conf; ldconfig"

USER developer
RUN cd /home/developer/ && sudo chmod a+r /2.4.10.4.zip && unzip /2.4.10.4.zip && \
    cd opencv-* && mkdir release && cd release && \
    cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j8 && sudo make install && \
    sudo ldconfig && \
    rm -rf /home/developer/opencv-*

USER root

EXPOSE 22
CMD ["supervisord", "-n", "-c", "/etc/supervisord.conf"]
