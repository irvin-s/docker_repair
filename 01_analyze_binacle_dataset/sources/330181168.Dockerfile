FROM centos:7
RUN yum update -y && yum install -y \
    curl \
    ca-certificates \
    yum-utils \
    epel-release
RUN yum install -y jq
RUN rpm --import https://download.docker.com/linux/centos/gpg
RUN yum-config-manager --add-repo "https://download.docker.com/linux/centos/docker-ce.repo"
RUN yum update -y && yum install --enablerepo=docker-ce-test -y \
    docker-ce
RUN mkdir /tool
WORKDIR /tool
COPY daemon.json /etc/docker/daemon.json
COPY diagnosticClient /tool/diagnosticClient
COPY wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker
CMD ["/usr/local/bin/wrapdocker"]