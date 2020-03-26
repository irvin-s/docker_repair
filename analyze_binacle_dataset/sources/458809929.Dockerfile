FROM phusion/baseimage:0.9.11
MAINTAINER Simon Kohlmeyer <simon.kohlmeyer@gmail.com>

# Install Java
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -y oracle-java7-installer

# Install youtrack
WORKDIR /home/youtrack
RUN wget -nv http://download.jetbrains.com/charisma/youtrack-6.0.12634.jar -O /youtrack.jar

ADD ./etc /etc

ADD ./ssh_pubkey /tmp/ssh_pubkey
RUN cat /tmp/ssh_pubkey >> /root/.ssh/authorized_keys && rm -f /tmp/ssh_pubkey
RUN chmod 600 /root/.ssh/authorized_keys

EXPOSE 80

CMD ["/sbin/my_init"]
