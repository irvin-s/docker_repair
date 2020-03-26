# Dockerfile for the ga4gh-streaming-freebayes container
FROM ubuntu:trusty
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends --no-install-suggests python-requests curl parallel aria2 pigz dstat libjemalloc-dev
COPY resources/ /
ADD https://raw.githubusercontent.com/dnanexus-rnd/htsnexus/master/client/htsnexus.py /usr/local/bin/htsnexus
RUN chmod +x /usr/local/bin/htsnexus
WORKDIR /app/
ENV SHELL=/bin/bash HOME=/app
ENTRYPOINT ["/app/main.sh"]
