FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y

RUN echo "Europe/Ljubljana" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

# basic utilities and fixes
RUN apt-get install -y pwgen python-setuptools && \
    easy_install supervisor
ADD cfgs/supervisord.conf /etc/supervisord.conf

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
    wget https://github.com/Itseez/opencv/archive/2.4.10.4.zip -O /2.4.10.4.zip

RUN  bash -c "echo /usr/local/lib >> /etc/ld.so.conf; ldconfig" && \
    /bin/bash -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'

# http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/
RUN apt-get install -y x11-apps  && \
# Replace with your user / group id
    export uid=499 gid=100 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer && \
    /bin/bash -c "echo 'developer:developerpw' | chpasswd" && \
    usermod -a -G video developer && \
# ssh https://docs.docker.com/examples/running_ssh_service/
#   and SSH login fix. Otherwise user is kicked off after login
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd

USER developer
RUN cd /home/developer/ && sudo chmod a+r /2.4.10.4.zip && unzip /2.4.10.4.zip && \
    cd opencv-* && mkdir release && cd release && \
    cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
    make && sudo make install && \
    sudo ldconfig && \
    rm -rf /home/developer/opencv-*

# java8 for gradle and android studio
RUN sudo wget --no-cookies --header "Cookie: oraclelicense=foo" http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz -O /jdk-8u101-linux-x64.tar.gz && \
    tar xzf /jdk-8u101-linux-x64.tar.gz -C /home/developer/

# sdk, ndk
RUN sudo wget http://dl.google.com/android/repository/android-ndk-r12b-linux-x86_64.zip -O /android-ndk-r12b-linux-x86_64.zip && \
    unzip /android-ndk-r12b-linux-x86_64.zip -d /home/developer/ && \
    sudo wget https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz -O /android-sdk_r24.4.1-linux.tgz && \
    tar xzf /android-sdk_r24.4.1-linux.tgz -C /home/developer/

# for sdk manager gui
RUN sudo apt-get update && \
    sudo apt-get install -y openjdk-7-jdk

RUN echo 'export JAVA="/home/developer/jdk1.8.0_101/bin"' >> /home/developer/.bashrc && \
    echo 'export JAVA_HOME="/home/developer/jdk1.8.0_101"' >> /home/developer/.bashrc && \
    echo 'export STUDIO_JDK="/home/developer/jdk1.8.0_101"' >> /home/developer/.bashrc && \
    echo 'export PATH="$JAVA:$PATH"' >> /home/developer/.bashrc && \
    echo 'export ANDROID_HOME="/home/developer/android-sdk-linux"' >> /home/developer/.bashrc && \
    echo 'export ANDROID_TOOLS="/home/developer/android-sdk-linux/tools"' >> /home/developer/.bashrc && \
    true

RUN echo "y" | /home/developer/android-sdk-linux/tools/android update sdk --filter build-tools-24.0.1,extra-android-m2repository,android-15,android-21,android-24,platform-tools --no-ui

RUN sudo wget http://downloads.sourceforge.net/project/opencvlibrary/opencv-android/2.4.10/OpenCV-2.4.10-android-sdk.zip -O /OpenCV-2.4.10-android-sdk.zip && \
    unzip /OpenCV-2.4.10-android-sdk.zip -d /home/developer/

RUN sudo wget https://dl.google.com/dl/android/studio/ide-zips/2.1.2.0/android-studio-ide-143.2915827-linux.zip -O /android-studio-ide-143.2915827-linux.zip && \
    unzip /android-studio-ide-143.2915827-linux.zip -d /home/developer/

# obsolete google-m2repo (required by android studio)
RUN echo "y" | ~/android-sdk-linux/tools/android update sdk -a --filter extra-google-m2repository --no-ui
# update tools
RUN echo "y" | bash -c "/home/developer/android-sdk-linux/tools/android update sdk --filter tools --no-ui; rmdir /home/developer/android-sdk-linux/tools; unzip /home/developer/android-sdk-linux/temp/tools_*-linux.zip -d /tmp/; mv /tmp/tools/ /home/developer/android-sdk-linux/"

RUN /bin/echo -e "if [ -f ~/.bashrc ]; then\n.    ~/.bashrc\nfi" >> /home/developer/.bash_login

RUN sudo usermod -a -G audio developer

USER root

EXPOSE 22
CMD ["supervisord", "-n", "-c", "/etc/supervisord.conf"]
