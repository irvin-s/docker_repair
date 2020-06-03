FROM ambakshi/amazon-linux:2017.03

ENV container docker

RUN rm -rf /etc/yum.repos.d/amzn-*
RUN echo $'[centos]\nname=CentOS\nmirrorlist=http://mirrorlist.centos.org/?release=6&arch=$basearch&repo=os\nenabled=1\ngpgcheck=0' > /etc/yum.repos.d/centos.repo
RUN yum install -y git

RUN curl -k --silent \
    https://nodejs.org/dist/v6.10.3/node-v6.10.3-linux-x64.tar.gz | \
    tar --strip-components 1 -xzf - -C /usr/local/
RUN npm install -g serverless@1.23.0

WORKDIR /home/ec2user

CMD bash
