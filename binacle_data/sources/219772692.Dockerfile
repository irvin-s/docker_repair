FROM jpetazzo/dind

RUN apt-get update && \
    apt-get install -y vim nano mc python-pip

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN pip install docker-compose

WORKDIR /root/
ADD tutorial/ /root/tutorial/

ADD .bash* /root/
ADD boot.msg /etc/motd
