FROM ubuntu:12.04.5

RUN apt-get -y update && \
  apt-get -y install \
  python3 \
  python-pip

CMD bash '/etc/shared/scripts/drive'
