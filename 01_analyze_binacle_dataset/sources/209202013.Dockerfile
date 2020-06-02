#Build docker image with:
# $ sudo docker build -t lisk-main .
#Run image with:
# $ docker run -it lisk-main
#Remember to commit to preserve state

FROM ubuntu:16.04

RUN apt-get -y update && apt-get install -y curl wget tar sudo unzip zip git ntp language-pack-en-base sudo vim systemd-cron ntpdate screen
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

RUN useradd -m -p `perl -e 'printf("%s\n", crypt($ARGV[0], "password"))' liskpwd` -s /bin/bash lisk
RUN usermod -aG sudo lisk
RUN echo lisk ALL=\(ALL\) NOPASSWD: ALL > /etc/sudoers.d/lisk

RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
RUN apt-get -y install nodejs

RUN mkdir -p /path/to
RUN chown -R lisk /path

USER lisk
WORKDIR /home/lisk
RUN git clone https://github.com/filipealmeida/liskak
WORKDIR /home/lisk/liskak
RUN npm install
RUN echo export PATH=\${PATH}:/path/to/liskak/tools:/path/to/liskak >> /home/lisk/.bashrc

USER root
RUN ln -s /home/lisk/liskak/ /path/to/liskak
RUN ln -s /home/lisk/lisk-main/ /path/to/lisk

USER lisk
WORKDIR /home/lisk
RUN wget https://downloads.lisk.io/scripts/installLisk.sh
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
RUN bash installLisk.sh install -r main -n -d /home/lisk
