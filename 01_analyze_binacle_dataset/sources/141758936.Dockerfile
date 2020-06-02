From centos:centos7
RUN yum install -y yum-utils wget gcc g++ git vi net-tools libaio hwloc python-mysqldb openssh-server

RUN yum install -y python-pip
RUN pip install --upgrade pip
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

RUN rpm --import "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
RUN curl https://download.mono-project.com/repo/centos7-stable.repo | tee /etc/yum.repos.d/mono-centos7-stable.repo
RUN yum -y install mono-complete

COPY init.sh /opt/init.sh
RUN chmod 777 /opt/init.sh

RUN ssh-keygen -t rsa -N ""  -f "/root/.ssh/id_rsa"

WORKDIR /opt/
CMD ["/opt/init.sh"]