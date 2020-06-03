##########################################
# Dockerfile for udata
##########################################

FROM udata/system

MAINTAINER Open Data Team

# Install some production system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    # uWSGI rooting features
    libpcre3-dev \
    # Clean up
    && apt-get autoremove\
    && apt-get clean\
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install udata and all known plugins
COPY requirements.pip /tmp/requirements.pip
RUN pip install -r /tmp/requirements.pip

RUN mkdir -p /udata/fs /src

COPY udata.cfg entrypoint.sh /udata/
COPY uwsgi/*.ini /udata/uwsgi/

WORKDIR /udata

VOLUME /udata/fs

ENV UDATA_SETTINGS /udata/udata.cfg

EXPOSE 7000 7001

HEALTHCHECK --interval=5s --timeout=3s CMD curl --fail http://localhost:7000/ || exit 1

ENTRYPOINT ["/udata/entrypoint.sh"]
CMD ["uwsgi"]
