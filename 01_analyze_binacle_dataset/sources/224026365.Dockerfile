FROM quay.io/deis/base:v0.3.6

RUN buildDeps='gcc git libffi-dev libssl-dev python3-dev python3-pip python3-wheel python3-setuptools'; \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        $buildDeps \
        libffi6 \
        libssl1.0.0 \
        python3-minimal && \
	pip3 install --disable-pip-version-check --no-cache-dir docker-py==1.10.6 && \
    # cleanup
    apt-get purge -y --auto-remove $buildDeps && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    # package up license files if any by appending to existing tar
    COPYRIGHT_TAR='/usr/share/copyrights.tar'; \
    gunzip -f $COPYRIGHT_TAR.gz; tar -rf $COPYRIGHT_TAR /usr/share/doc/*/copyright; gzip $COPYRIGHT_TAR && \
    rm -rf \
        /usr/share/doc \
        /usr/share/man \
        /usr/share/info \
        /usr/share/locale \
        /var/lib/apt/lists/* \
        /var/log/* \
        /var/cache/debconf/* \
        /etc/systemd \
        /lib/lsb \
        /lib/udev \
        /usr/lib/x86_64-linux-gnu/gconv/IBM* \
        /usr/lib/x86_64-linux-gnu/gconv/EBC* && \
    bash -c "mkdir -p /usr/share/man/man{1..8}"

ADD https://storage.googleapis.com/object-storage-cli/bb8e054/objstorage-bb8e054-linux-amd64 /bin/objstorage
RUN chmod +x /bin/objstorage

COPY . /

CMD ["python3", "/deploy.py"]
