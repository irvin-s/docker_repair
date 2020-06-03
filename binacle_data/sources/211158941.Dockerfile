FROM ubuntu:15.10
ADD https://releases.rancher.com/compose/v0.7.4/binaries/linux-amd64/rancher-compose /usr/bin
RUN chmod +x /usr/bin/rancher-compose
COPY cowbell /usr/bin/
CMD ["cowbell"]
