FROM scratch
MAINTAINER Weaveworks Inc <help@weave.works>
WORKDIR /home/weave
ADD ./weavediscovery /home/weave/
COPY ca-certificates.crt /etc/ssl/certs/
EXPOSE 6789/tcp
ENTRYPOINT ["/home/weave/weavediscovery"]
