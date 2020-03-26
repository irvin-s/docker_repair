FROM ubuntu:18.04

LABEL maintainer="Vladimir Grevtsev vlgrevtsev@gmail.com"

WORKDIR /home

RUN mkdir ~/.ssh && /bin/echo -e "Host *  \n StrictHostKeyChecking no" > ~/.ssh/config
RUN apt-get update && apt-get install -y wget unzip python-pip python-virtualenv git rsync
RUN pip install awscli jinja2==2.10 ansible==2.7.2
RUN wget https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip -O terraform.zip && \
    unzip terraform.zip && mv terraform /usr/local/bin

CMD ["bash"]
