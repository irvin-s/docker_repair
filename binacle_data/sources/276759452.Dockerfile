FROM jenkins/jenkins:lts

# install terraform
USER root
RUN wget https://releases.hashicorp.com/terraform/0.10.3/terraform_0.10.3_linux_amd64.zip && unzip terraform_0.10.3_linux_amd64.zip && mv terraform /usr/bin/ && chmod 755 /usr/bin/terraform && rm terraform_0.10.3_linux_amd64.zip

# install build, test tool
RUN apt-get update && apt-get install -y vim build-essential python-pip python-setuptools python-wheel groff jq ruby --no-install-recommends && rm -rf /var/lib/apt/lists/* && pip install --no-cache-dir awscli && gem install awspec bundler

# install plugins
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
