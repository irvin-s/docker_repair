FROM jfactory/common-slave:latest
MAINTAINER Sławek Piotrowski <sentinel@atteo.com>

# versions
# Latest stable: curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt
ENV TERRAFORM_VERSION=0.11.7 \
    TERRAFORM_HOME=/usr/share/terraform \
    DOCKER_COMPOSE_VERSION=1.23.2 \
	KUBERNETES_VERSION=v1.13.0

USER root

# azure, aws, google cloud and docker
RUN \
	apt-get update && \
	apt-get install -y gnupg2 apt-transport-https ca-certificates software-properties-common xmlstarlet python3-yaml && \
    echo "===> add azure repo" && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ stretch main" | tee /etc/apt/sources.list.d/azure-cli.list && \
	curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
	curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
	add-apt-repository \
	   "deb [arch=amd64] https://download.docker.com/linux/debian \
	      $(lsb_release -cs) \
		  stable" \
    && \
	echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get -y update && \
    \
    \
    echo "===> install cloud tools" && \
    apt-get install -y unzip docker-ce azure-cli awscli jq gettext-base netcat-openbsd google-cloud-sdk postgresql-client-9.6 && \
    usermod -aG docker jenkins && \
    \
    \
    echo "===> clean" && \
    apt-get -y clean  && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# terraform
RUN mkdir -p $TERRAFORM_HOME \
  && curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o bin.zip \
  && unzip bin.zip -d $TERRAFORM_HOME \
  && ln -s $TERRAFORM_HOME/terraform /usr/bin/terraform \
  && rm bin.zip

# Docker compose
RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
	chmod +x /usr/local/bin/docker-compose

# Kubernetes
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

