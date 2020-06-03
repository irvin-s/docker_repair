FROM ubuntu:16.04
RUN apt-get update && \
	apt-get install -y \
		iputils-ping \
		openssh-server \
		sudo \
		python \
		python-apt
RUN mkdir /var/run/sshd
COPY id_rsa.pub /root/.ssh/authorized_keys
ENV TERM xterm
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D", "-4"]
