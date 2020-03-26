FROM strato-build

RUN install-deb http://http.us.debian.org/debian/pool/main/c/ca-certificates/ca-certificates_20161130+nmu1_all.deb
RUN mkdir -p /etc/ssl/certs \
    && cp -r /usr/share/ca-certificates/mozilla/* /etc/ssl/certs/
