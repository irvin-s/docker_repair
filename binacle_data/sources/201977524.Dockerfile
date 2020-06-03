FROM       tune_platform/freight-forwarder-wheel:latest
MAINTAINER Alex Banna alexb@tune.com
ENV        REFRESHED_AT 2016-01-22

# upgrade pip and install tox.
RUN pip install --upgrade pip && \
    pip install tox

ENTRYPOINT ["tox"]
