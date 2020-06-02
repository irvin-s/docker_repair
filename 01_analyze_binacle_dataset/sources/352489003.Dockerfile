FROM debian:sid

RUN apt-get update && \
    apt-get install -y filezilla && \
    rm -rf /var/cache/apt/*

ENTRYPOINT ["filezilla"]
