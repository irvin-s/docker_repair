FROM centos:centos6

RUN     yum -y update
RUN     yum -y groupinstall "Development Tools"
RUN     yum install -y wget
RUN     yum install -y tar

RUN cd /usr/src && wget https://nodejs.org/dist/v0.12.0/node-v0.12.0-linux-x64.tar.gz && \
    tar zxf node-v0.12.0-linux-x64.tar.gz && \
    cp -rp node-v0.12.0-linux-x64 /usr/local/ && \
    ln -s /usr/local/node-v0.12.0-linux-x64 /usr/local/node

ENV PATH /usr/local/node/bin:$PATH

# Bundle app source
COPY ./ /src

# Install app dependencies
# RUN cd /src && npm install

entrypoint ["node", "/src/index.js"]
