FROM registry:2.6.0

RUN apk add --no-cache \
        python3 && \
    python3 -m ensurepip && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    ln -sf /usr/bin/pip3 /usr/bin/pip

RUN buildDeps='gcc git linux-headers musl-dev python3-dev' && \
    apk add --no-cache $buildDeps && \
    # "upgrade" boto to 2.43.0 + the patch to fix minio connections
    pip install --disable-pip-version-check --no-cache-dir --upgrade \
        git+https://github.com/deis/boto@88c980e56d1053892eb940d43a15a68af4ebb5e6 \
        azure==1.0.3 \
        gcloud==0.18.3 \
        python-swiftclient==3.1.0 \
        python-keystoneclient==3.1.0 && \
    # purge dev dependencies
    apk del $buildDeps

COPY . /

VOLUME ["/var/lib/registry"]
CMD ["/opt/registry/sbin/registry"]
EXPOSE 5000
