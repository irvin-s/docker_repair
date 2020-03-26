FROM fedora:23

RUN dnf -y install wget curl git unzip jq python python-pip python-boto3 awscli ansible docker

RUN curl https://releases.hashicorp.com/terraform/0.6.12/terraform_0.6.12_linux_amd64.zip -o /tmp/terraform_0.6.12_linux_amd64.zip

WORKDIR /usr/local/bin/
RUN unzip /tmp/terraform_0.6.12_linux_amd64.zip

RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh
RUN echo -e "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

WORKDIR /deploy
ADD main.tf config ./
ADD scripts scripts/
ADD ansible ansible/

ENTRYPOINT [ "/deploy/scripts/run.sh" ]
