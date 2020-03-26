FROM mysql:5.6
MAINTAINER @qxip (twitter)
RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/sipcapture/homer-api.git /homer-api && cd /homer-api && git checkout 5cc1bac9187e2d6413cbf8f28b37747ce364b373 && cd /
ADD bootstrap.sh /bootstrap.sh