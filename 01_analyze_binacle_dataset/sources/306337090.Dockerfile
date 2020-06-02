FROM jenkins:latest
MAINTAINER cookeem cookeem@qq.com

USER root

# 安装kubectl
RUN apt-get update && apt-get install -y apt-transport-https
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y kubectl

USER jenkins
ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]

# docker build -t jenkins-kube:latest jenkins-kube/
