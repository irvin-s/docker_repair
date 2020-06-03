FROM debian:stretch

ARG TERRAFORM_VERSION=0.11.7

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y curl unzip git && \ 
    curl -L -o /opt/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    cd /usr/local/bin && unzip /opt/terraform.zip && rm -f /opt/terraform.zip && \
    mkdir /github

WORKDIR /app
COPY . /app

ENTRYPOINT [ "/app/entrypoint.sh" ]
