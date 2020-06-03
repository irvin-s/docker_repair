FROM          python:3.6.6

RUN           apt-get update
RUN           apt-get install -y socat

# Optimization to not keep downloading dependencies on every build.
RUN           mkdir /app
COPY          ./README.md /app
COPY          ./setup.py /app
WORKDIR       /app
RUN           python setup.py install

COPY          . /app/
WORKDIR       /app
RUN           chmod +x entrypoint.sh
RUN           python setup.py install
ENV           ASSET_DIR /asyncy
ENV           logger_level info

ENTRYPOINT    ["/app/entrypoint.sh"]