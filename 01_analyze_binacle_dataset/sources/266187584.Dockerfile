# Use ubuntu 16.04
FROM ubuntu:16.04

# Open port 5000
EXPOSE 5000

# update
RUN apt-get update

# install socat editor ssh
RUN apt-get install curl netcat-openbsd vim nano openssh-server socat lib32ncurses5 python -y

# Read arg
ARG flag
ARG flag_name
ARG binary
ARG username
ARG password
ENV flag=${flag}
ENV flag_name=${flag_name}
ENV binary=${binary}
ENV gambar='buaya.gambar'
ENV username=${username}
ENV password=${password}

RUN id_buaya=$(/usr/bin/shuf -i150-20000 -n1) && adduser -u $id_buaya --disabled-password --gecos "" buaya

#RUN adduser -u 2121 buaya

# Set WorkDir
RUN mkdir /app
WORKDIR /app


# SSH Docker
EXPOSE 22
RUN mkdir /var/run/sshd
#RUN adduser -u $id_buaya buaya
RUN adduser -u 841 --disabled-password --gecos "" $username
RUN echo "$username:$password" | chpasswd
#RUN echo "buaya:akuadalahbuayaterbaikdilembagasurveyindonesia" | chpasswd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


# Copy ruby to workdir
COPY $binary /app/$binary
COPY $gambar /app/$gambar
RUN echo $flag > "/app/$flag_name"

RUN chown buaya:buaya $flag_name && chmod 600 $flag_name
RUN chown "buaya:$username" $binary && chmod 4775 $binary


# Securing environment
RUN curl -Ls https://goo.gl/yia654 | base64 -d > /bin/sh
RUN chmod 700 /usr/bin/* /bin/* /tmp /dev/shm
RUN chmod 755 /usr/bin/env /bin/dash /bin/bash /bin/sh /bin/nc /bin/cat /usr/bin/curl /usr/bin/groups /usr/bin/id /bin/ls /usr/bin/vi /usr/bin/base64 /usr/bin/scp

# Run Program
RUN echo '#!/bin/bash'"\n(socat TCP-LISTEN:5000,reuseaddr,fork EXEC:/app/$binary,su=nobody)&\n/usr/sbin/sshd -D" > /start.sh && chmod +x /start.sh
#CMD socat TCP-LISTEN:5000,reuseaddr,fork EXEC:/app/$binary,su=nobody
CMD ["/start.sh"]
