FROM ubuntu:16.04
RUN apt-get update && apt-get -y install sudo curl git-core build-essential rsync libgraphicsmagick1-dev vim python
RUN curl -fs https://raw.githubusercontent.com/mafintosh/node-install/master/install | sh && node-install 6.11.3
RUN npm install -g expose-fs@1.5.1 streaming-format@1.1.0
ADD run-container /run-container
WORKDIR /root
ENTRYPOINT /run-container