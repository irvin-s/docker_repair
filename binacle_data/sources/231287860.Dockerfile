FROM strato-build

# TODO: this shouldn't need to be removed
RUN rm /usr/share/doc/openssl/changelog.gz

RUN install-deb http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.0.0_1.0.2g-1ubuntu4.10_amd64.deb \
    && install-deb http://security.ubuntu.com/ubuntu/pool/main/o/openssl/openssl_1.0.2g-1ubuntu4.10_amd64.deb
