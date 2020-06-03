FROM        kintoandar/centos-6.5-x86_64:latest
MAINTAINER  Joel Bastos <kintoandar@gmail.com>

RUN rpm -ivh http://mirrors.nl.eu.kernel.org/fedora-epel/6/i386/epel-release-6-8.noarch.rpm && \
  rpm -ivh http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm && \
  yum install golang nginx git mysql mysql-server -y
COPY ["setup.sql", ".my.cnf", "mixer.conf", "/root/"]
ENV GOPATH /usr/share/gocode
WORKDIR $GOPATH
RUN go get github.com/etsy/mixer && \
  cd $GOPATH/src/github.com/etsy/mixer && \
  cp config.cfg.sample config.cfg && \
  cp config-secrets.cfg.sample config-secrets.cfg && \
  sed -i '/password/d' config-secrets.cfg && echo 'password="changeme"' >> config-secrets.cfg && \
  sed -i '/sysconfig\/network/d' /etc/init.d/mysqld && \
  /etc/init.d/mysqld start && chkconfig mysqld on && sleep 5 && \
  grep 'temporary password' /var/log/mysqld.log|awk -F ": " {'print "password="$2'} >> /root/.my.cnf && \
  mysql -u root --connect-expired-password < /root/setup.sql && \
  sed -i '/password/d' /root/.my.cnf && echo 'password=changemePLEASE' >> /root/.my.cnf && \
  /etc/init.d/mysqld stop && \
  sed -i '/sysconfig\/network/d' /etc/init.d/nginx && \
  mv /root/mixer.conf /etc/nginx/conf.d/ && chkconfig nginx on
EXPOSE 8080
CMD /etc/init.d/mysqld start && /etc/init.d/nginx start && cd $GOPATH/src/github.com/etsy/mixer/ && go run mixer.go
