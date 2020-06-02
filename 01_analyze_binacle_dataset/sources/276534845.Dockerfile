FROM openjdk:8-jdk
MAINTAINER Marius Wöste

ARG UID=1000
ARG GID=1000

COPY . /viper

RUN apt-get update && \
  apt-get install -y xvfb gradle curl wget gtk+3.0 zip && \
  curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
  apt-get install -y nodejs && \
  npm config set registry http://registry.npmjs.org/ && \
  npm install -g bower && \
  npm install -g grunt-cli && \
  curl -o /viper/igv.jar https://uni-muenster.sciebo.de/index.php/s/7YptrvcDLz56tn7/download && \
  groupadd -g ${GID} workforce && \
  useradd -m -u ${UID} -g ${GID} worker && \
  chown -R worker /viper

USER worker

RUN cd /viper && ./build.sh

CMD cd /viper && gradle test
