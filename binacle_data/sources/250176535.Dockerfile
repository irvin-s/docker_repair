FROM fedora:28
MAINTAINER https://github.com/JacobCallahan

ENV HOME /root
WORKDIR /root

RUN dnf install -y subscription-manager openssh-server
RUN sleep .1 ; printf "%s\n" "dog8code" "dog8code" | passwd
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

ADD startup.sh /tmp/
RUN chmod +x /tmp/startup.sh

EXPOSE 22

CMD /tmp/startup.sh
