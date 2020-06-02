FROM phusion/baseimage:latest
MAINTAINER grv@dfdx.me

RUN apt-get -y -q update && \
    apt-get -y -q install software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get -y -q update && \
    apt-get install -qqy \
        openjdk-8-jdk \
        libjna-java 

ADD authorized_keys /root/.ssh/
RUN chmod 600 /root/.ssh/authorized_keys
RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN apt-get -y -q install curl iptables iputils-ping inetutils-telnet dnsutils
EXPOSE 8000
RUN mkdir /app
RUN mkdir /etc/service/distdb
ADD distdb.sh /etc/service/distdb/run
ADD distdb-assembly-1.0.jar /app/
CMD ["/sbin/my_init"]