FROM themattrix/tox-base

COPY requirements-test.txt setup.py tox.ini /app/

RUN chown -R tox:tox /app/
RUN gosu tox bash -c "TOXBUILD=true tox"

COPY docker-entrypoint.sh /
