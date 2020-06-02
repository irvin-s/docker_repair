FROM       ubuntu:trusty
MAINTAINER Paulo Cesar "https://github.com/pocesar"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get dist-upgrade -q -y > /dev/null

RUN apt-get install -y openssh-server git
RUN mkdir -m 0755 /var/run/sshd

ENV PUBLIC_KEY ""
ENV IN ""
ENV USER git

RUN sed -ri 's/#?RSAAuthentication\s+.*/RSAAuthentication yes/' /etc/ssh/sshd_config
RUN sed -ri 's/#?PermitRootLogin\s+.*/PermitRootLogin no/' /etc/ssh/sshd_config
RUN sed -ri 's/#?PasswordAuthentication\s+.*/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN sed -ri 's/#?PermitEmptyPasswords\s+.*/PermitEmptyPasswords no/' /etc/ssh/sshd_config
RUN sed -ri 's/#?PubkeyAuthentication\s+.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
RUN sed -ri 's/#?UseLogin\s+.*/UseLogin no/' /etc/ssh/sshd_config
RUN sed -ri 's/#?LogLevel\s+.*/LogLevel INFO/' /etc/ssh/sshd_config
RUN sed -ri 's/#?UsePAM\s+.*/UsePAM yes/g' /etc/ssh/sshd_config

ADD run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 22

CMD ["/run.sh"]
