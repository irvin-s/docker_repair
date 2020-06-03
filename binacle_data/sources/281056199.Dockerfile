# pull base image
FROM ubuntu:14.04

RUN \
  apt-get update && \
  apt-get install -y python && \
  rm -rf /var/lib/apt/lists/*

COPY ./atm.py /data/
COPY ./entrypoint.sh /data/

WORKDIR /data/

ENTRYPOINT ["/data/entrypoint.sh"]

CMD ["bash"]
