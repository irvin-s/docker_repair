FROM scratch
ADD ./ca-certificates.crt /etc/ssl/certs/
COPY ./slack-blackhole /slack-blackhole
CMD ["/slack-blackhole"]
