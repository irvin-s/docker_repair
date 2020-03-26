FROM ubuntu

RUN apt-get update

RUN apt-get install -y openssh-server vim

RUN mkdir /var/run/sshd

ADD trusted-user-ca-keys.pem /etc/ssh/trusted-user-ca-keys.pem

RUN echo 'root:changeme' | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN echo 'TrustedUserCAKeys /etc/ssh/trusted-user-ca-keys.pem' >> /etc/ssh/sshd_config
RUN service ssh restart
RUN useradd -m -d /home/ubuntu -s /bin/bash ubuntu
RUN echo 'ubuntu:newpasswd' | chpasswd

EXPOSE 22

CMD [ "/usr/sbin/sshd", "-D" ]
