From centos:centos7
MAINTAINER Hongjie Zhao <zhaohongjie@actionsky.com>

RUN yum install -y yum-utils wget gcc g++ git vi net-tools libaio hwloc MySQL-python openssh-server openssh-clients sshpass libmysqlclient-dev

#install jdk
COPY jdk-8u121-linux-x64.tar.gz /tmp/jdk-8u121-linux-x64.tar.gz
RUN mkdir /opt/jdk
RUN tar -zxvf /tmp/jdk-8u121-linux-x64.tar.gz -C /opt/jdk --strip-components=1
RUN echo "export JAVA_HOME=/opt/jdk">>/etc/bashrc
RUN echo "export PATH=/opt/jdk/bin:$PATH">>/etc/bashrc

#install pip and requirements
RUN yum install -y epel-release
RUN yum install -y  python-pip
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r /tmp/requirements.txt

#.net dependency
RUN rpm --import "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
RUN curl https://download.mono-project.com/repo/centos7-stable.repo | tee /etc/yum.repos.d/mono-centos7-stable.repo
RUN yum -y install mono-complete

RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N ''
RUN ssh-keygen -t rsa -N ""  -f "/root/.ssh/id_rsa"

COPY * /docker-build/

ENTRYPOINT ["/usr/sbin/sshd", "-D"]