FROM centos:7

MAINTAINER wikift

RUN mkdir /wikift

VOLUME /wikift

WORKDIR /wikift

ADD wikift-1.0.0.tar.gz ./

WORKDIR /wikift/wikift-1.0.0

RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -

RUN yum install -y nodejs

RUN npm install -g cnpm

RUN cnpm install -g @angular/cli

EXPOSE 4200

CMD /bin/bash -c 'cnpm install; npm start'
