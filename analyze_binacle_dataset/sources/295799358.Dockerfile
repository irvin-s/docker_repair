# Build: run ooni-sysadmin.git/scripts/docker-build from this directory

FROM python:2.7

# `psycopg2-binary` brings its own libpq and libssl, see http://initd.org/psycopg/docs/install.html#binary-install-from-pypi
RUN set -ex \
    && pip2.7 install --target /usr/local/lib/python2.7/site-packages psycopg2-binary GitPython \
    && rm -rf /root/.cache \
    && :

COPY sync-test-lists.py /usr/local/bin/

USER daemon
