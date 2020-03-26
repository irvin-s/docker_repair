FROM legcowatch/appserver

# Set up the development environment
COPY files/.bashrc /root/.bashrc
COPY files/.profile /root/.profile

# Set up SSH
# From http://docs.docker.com/examples/running_ssh_service/
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:foo' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Set up gosu
RUN curl -o /usr/local/bin/gosu -SL 'https://github.com/tianon/gosu/releases/download/1.0/gosu' \
	&& chmod +x /usr/local/bin/gosu

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
EXPOSE 8000
ENTRYPOINT ["/usr/sbin/sshd", "-D"]

VOLUME /docker
