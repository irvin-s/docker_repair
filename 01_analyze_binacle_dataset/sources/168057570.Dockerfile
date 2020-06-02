FROM alpine
MAINTAINER David Personette <dperson@gmail.com>

# Install uwsgi and MoinMoin
RUN file=moin-1.9.10.tar.gz && \
    sha256sum=4a264418e886082abd457c26991f4a8f4847cd1a2ffc11e10d66231da8a50 && \
    apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add bash curl py2-markdown tini \
                uwsgi-python shadow && \
    echo "downloading $file ..." && \
    curl -LOSs http://static.moinmo.in/files/$file && \
    sha256sum $file | grep -q "$sha256sum" || \
    { echo "expected $sha256sum, got $(sha256sum $file)"; exit 13; } && \
    mkdir moinmoin && \
    tar -xf $file -C moinmoin --strip-components=1 && \
    (cd moinmoin && \
    python setup.py install --force --prefix=/usr/local >/dev/null) && \
    sed -e '/logo_string/ { s/moinmoin/docker/; s/MoinMoin // }' \
                -e '/url_prefix_static/ {s/#\(url_prefix_static\)/\1/; s/my//}'\
                -e '/page_front_page.*Front/s/#\(page_front_page\)/\1/' \
                -e '/superuser/ { s/#\(superuser\)/\1/; s/YourName/mmAdmin/ }' \
                -e '/page_front_page/s/#u/u/' \
                /usr/local/share/moin/config/wikiconfig.py \
                >/usr/local/share/moin/wikiconfig.py && \
    chown -Rh uwsgi. /usr/local/share/moin/data \
                /usr/local/share/moin/underlay && \
    rm -rf /tmp/* $file moinmoin raw

COPY docker.png /usr/local/lib/python2.7/site-packages/MoinMoin/web/static/htdocs/common/
COPY moin.sh /usr/bin/

EXPOSE 3031

HEALTHCHECK --interval=60s --timeout=15s \
            CMD netstat -lntp | grep -q '0\.0\.0\.0:3031'

VOLUME ["/usr/local/share/moin"]

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/moin.sh"]