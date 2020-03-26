FROM 10.63.241.108:5000/centos
MAINTAINER xiongguang

#net-tools install
RUN rm -rf /etc/yum.repos.d/*
RUN echo '[base]' > /etc/yum.repos.d/zte-mirror.repo
RUN echo 'name=CentOS-$releasever - Base' >> /etc/yum.repos.d/zte-mirror.repo
RUN echo 'baseurl=http://mirrors.zte.com.cn/centos/$releasever/os/$basearch/' >> /etc/yum.repos.d/zte-mirror.repo
RUN echo 'gpgcheck=0' >> /etc/yum.repos.d/zte-mirror.repo
ENV no_proxy "10.0.0.0/8, 127.0.0.1, .zte.com.cn, localhost, 172.17.0.0/16"

RUN yum install net-tools.x86_64 -y
RUN yum install dos2unix.x86_64 -y
RUN yum install java-1.8.0-openjdk.x86_64 -y
RUN yum install expect.x86_64 -y
RUN yum install zip.x86_64 -y
RUN yum install unzip.x86_64 -y
RUN yum install tar.x86_64 -y
RUN yum -y install openssh-server
RUN yum -y install openssh-clients
RUN useradd admin
RUN echo "admin:admin"|chpasswd
RUN echo  "admin  ALL=(ALL)  ALL">>/etc/sudoers
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN  mkdir  /var/run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd","&amp;"] 
#mkdir in container
RUN mkdir -p /home/tools/nginx
RUN mkdir -p /home/rdk_server
RUN mkdir -p /home/rdk_version

COPY rdk-runtime-environment*.zip /home/rdk_version/
COPY nginx-1.4.7  /home/tools/nginx

#CI:build deploy junit
COPY build.sh /home/rdk_server/
WORKDIR /home/rdk_server
RUN chmod +x build.sh
CMD ./build.sh 'console'
