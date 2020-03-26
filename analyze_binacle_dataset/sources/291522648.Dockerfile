FROM ubuntu:17.04
MAINTAINER Chris Troutner <chris.troutner@gmail.com>
RUN apt-get -y update
RUN apt-get install -y openssh-server
RUN apt-get install -y nano
RUN apt-get install -y ssh
RUN mkdir /var/run/sshd
RUN sed 's@sessions*requireds*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y nodejs
RUN apt-get install -y build-essential
WORKDIR /root
VOLUME /usr/src/app/logs
COPY package.json package.json
RUN npm install
EXPOSE 3100
COPY dummyapp.js dummyapp.js
COPY finalsetup finalsetup
COPY connect-client.js connect-client.js
COPY package.json package.json
COPY config.json config.json
RUN chmod 775 finalsetup
VOLUME /media/storage
RUN useradd -ms /bin/bash 2UWGUX29CT
RUN echo 2UWGUX29CT:msjceOaCYb | chpasswd
EXPOSE 6165
#ENTRYPOINT ["./finalsetup", "node", "dummyapp.js"]
ENTRYPOINT ["./finalsetup", "node", "connect-client.js"]
