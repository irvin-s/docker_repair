FROM python:latest

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get install -y build-essential
RUN apt-get install -y vim git
RUN apt-get install -y python3-dev
RUN apt-get install -y openssh-server

EXPOSE 22
RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

WORKDIR /data
RUN git clone https://github.com/XiaoboHe/XTrader.git

WORKDIR /data/XTrader
RUN pip install -r requirements.txt

RUN rm -rf /tmp/*
RUN rm -rf /var/lib/apt/lists/*

CMD ["/usr/sbin/sshd", "-D"]