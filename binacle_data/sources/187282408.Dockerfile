FROM ubuntu:18.04

# SETUP, CONFIG
ARG username=amet
ARG password=password
ARG shell=bash
ARG timezone=UTC
ARG lang=en_US.UTF-8
ARG syncFreq=900
ARG fsEngine=aufs
ARG groupname=$username
ARG userUid=1000
ARG userGid=1000

ENV DEV_USERNAME $username
ENV DEV_PASSWORD $password
ENV DEV_SHELL /bin/$shell
ENV DEV_SYNC_FREQ $syncFreq
ENV TZ $timezone

EXPOSE 3000

# REQUIRED FOR RUNNING CODE-SERVER AND OTHER AMET FEATURES
RUN apt-get update && apt-get install -y \
    git zsh apt-transport-https \
    ca-certificates curl software-properties-common \
    build-essential wget openssl net-tools locales \
    sudo openssh-server rsync vim && \
    echo "AuthorizedKeysFile %h/.ssh/authorized_keys %h/.ssh/authorized_keys2 /etc/ssh/%u/authorized_keys" >> /etc/ssh/sshd_config && \
    mkdir -p /etc/ssh/$username && \
    (locale-gen $lang || locale-gen en_US.UTF-8) && \
    ln -snf /usr/share/zoneinfo/$timezone /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get install tzdata

# INSTALL CODE-SERVER
RUN wget https://github.com/codercom/code-server/releases/download/1.691-vsc1.33.0/code-server1.691-vsc1.33.0-linux-x64.tar.gz && \
    tar -xvzf code-server1.691-vsc1.33.0-linux-x64.tar.gz -C /tmp && \
    mv /tmp/code-server1.691-vsc1.33.0-linux-x64/code-server /bin/code-server

# INSTALL DOCKER
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
   apt-key fingerprint 0EBFCD88 && \
   add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable" && \
   apt-get update && \
   apt-get install -y docker-ce && \
   mkdir /etc/docker && \
   echo "{\"storage-driver\":\"$fsEngine\"}" > /etc/docker/daemon.json && \
   service docker start

# CREATE USER
RUN groupadd $groupname -g $userGid && \
   useradd \
      -ms $DEV_SHELL \
      -u $userUid \
      -g $groupname \
      -p "$(openssl passwd -1 $DEV_PASSWORD)" \
      $username && \
   usermod -a -G docker,root $username && \
   echo "$username ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/nopasswd && \
   chmod 400 /etc/sudoers.d/nopasswd && \
   chown -R $username:root /etc/ssh/$username

# SWITCH TO USER. EVERYTHING BEYOND THIS POINT WILL BE DONE WITH USER'S UID/GID
WORKDIR /home/$username
USER $username:$groupname

# RUN USER CUSTOMIZATIONS
COPY ./.amet-customizer.sh /customizer.sh
RUN sh /customizer.sh

# STARTUP
COPY ./.amet-key.pub /etc/ssh/$username/authorized_keys
COPY ./homesync.sh /
COPY ./entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["code-server", "/home/$DEV_USERNAME/workspace", "-p", "3000", "-d", "/home/$DEV_USERNAME/code-server", "--password=$DEV_PASSWORD"]

