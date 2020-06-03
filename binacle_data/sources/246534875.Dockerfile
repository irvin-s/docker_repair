FROM ansible/ansible:ubuntu1604

RUN pip install testinfra ansible && mkdir -p /conjurinc/ansible-role-conjur/

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
RUN apt-get update && apt-get -y install docker-ce
RUN apt-get update && apt-get install -y gcc build-essential
RUN apt-add-repository -y ppa:brightbox/ruby-ng && apt-get update && apt-get install -y ruby2.4 ruby2.4-dev
RUN gem install conjur-cli

WORKDIR /conjurinc/ansible-role-conjur/
