FROM dojot/kong:v0.2.1

RUN yum -y update && yum -y install git && mkdir /plugins

RUN cd /plugins; git clone https://github.com/dojot/pep-kong pep-kong

RUN \
  luarocks install uuid 0.2-1; \
  luarocks install json4lua 0.9.30-1;
