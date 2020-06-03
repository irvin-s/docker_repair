FROM mysql:5.6.21

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ADD my.cnf /etc/mysql/my.cnf

ADD setup_local.sh /usr/local/mysql/setup_local.sh
RUN mkdir -p /etc/mysql
CMD ["./setup_local.sh",  "--user=root"]

