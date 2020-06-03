From centos:centos7
MAINTAINER Hongjie Zhao <zhaohongjie@actionsky.com>

#set chinses timezone
RUN echo "Asia/shanghai" > /etc/timezone;
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#libaio numaactl.x86_64 needed by mysql
RUN yum install -y wget net-tools libaio numactl.x86_64 openssh-clients openssh-server

#install jdk
COPY jdk-8u121-linux-x64.tar.gz /tmp/jdk-8u121-linux-x64.tar.gz
RUN mkdir /opt/jdk
RUN tar -zxvf /tmp/jdk-8u121-linux-x64.tar.gz -C /opt/jdk --strip-components=1
RUN echo "export JAVA_HOME=/opt/jdk">>/etc/bashrc
RUN echo "export PATH=$JAVA_HOME/bin:$PATH">>/etc/bashrc

#install mysql
COPY mysql-5.7.13-linux-glibc2.5-x86_64.tar.gz /tmp/mysql-5.7.13-linux-glibc2.5-x86_64.tar.gz
RUN mkdir /usr/local/mysql
RUN tar -zxvf /tmp/mysql-5.7.13-linux-glibc2.5-x86_64.tar.gz -C /usr/local/mysql --strip-components=1

RUN yum install -y openssl > /tmp/install_openssl.log

RUN groupadd mysql
RUN useradd -r -g mysql -s /bin/false mysql
RUN cd /usr/local/mysql && mkdir data && chown -R mysql:mysql .
RUN echo -e '[client] \nuser=test \npassword=111111 \nhost=127.0.0.1 \n[mysqld] \nserver-id=10 \nsession_track_schema=1 \nsession_track_state_change=1 \nsession_track_system_variables="*" \ngtid-mode=on \nenforce_gtid_consistency=on \nsecure_file_priv='' \nsql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES' > /etc/my.cnf
RUN rm -rf /var/lib/mysql
RUN echo "export PATH=/usr/local/mysql/bin:$PATH">>/etc/bashrc

#install btrace
COPY btrace-bin-1.3.11.tgz.tar.gz /tmp/btrace-bin-1.3.11.tgz.tar.gz
RUN mkdir /opt/btrace
RUN tar -zxvf /tmp/btrace-bin-1.3.11.tgz.tar.gz -C /opt/btrace
RUN sed -i 's/java -cp/java -Dcom.sun.btrace.unsafe=true -cp/' /opt/btrace/bin/btrace
RUN echo "export PATH=/opt/btrace/bin/:$PATH">>/etc/bashrc

#install zookeeper
COPY zookeeper-3.5.2-alpha.tar.gz /tmp/zookeeper-3.5.2-alpha.tar.gz
RUN mkdir /opt/zookeeper
RUN tar -zxvf /tmp/zookeeper-3.5.2-alpha.tar.gz -C /opt/zookeeper --strip-components=1
RUN echo " ">> /opt/zookeeper/conf/zoo.cfg \
    && sed -i "$ a tickTime=2000\ninitLimit=10\nsyncLimit=5 \nclientPort=2181" /opt/zookeeper/conf/zoo.cfg \
    && sed -i "$ a dataDir=/opt/zookeeper/data\ndataLoginDir=/opt/zookeeper/logs" /opt/zookeeper/conf/zoo.cfg \
    && sed -i "$ a server.1=dble-1:2888:3888\nserver.2=dble-2:2888:3888\nserver.3=dble-3:2888:3888" /opt/zookeeper/conf/zoo.cfg \
    && mkdir /opt/zookeeper/data/

RUN echo "export PATH=/opt/zookeeper/bin:/opt/btrace/bin/:/usr/local/mysql/bin:/opt/jdk/bin:$PATH">>/etc/bashrc

COPY mysql_init.sh /usr/local/bin/mysql_init.sh
RUN chmod +x /usr/local/bin/mysql_init.sh

RUN ssh-keygen -A
RUN mkdir ~/.ssh
RUN echo 'sshpass'| passwd --stdin root

RUN rm -r /tmp/*.tar.gz

#sshd service
RUN rm -rf /etc/ssh/ssh_host_*
RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N ''
RUN ssh-keygen -t rsa -N ""  -f "/root/.ssh/id_rsa"

COPY * /docker-build/

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN ln -s /usr/local/bin/docker-entrypoint.sh /

ENTRYPOINT ["docker-entrypoint.sh"]