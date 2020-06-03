FROM debian:stable-slim

ENV PYTHONUNBUFFERED=1 DOCKER=1 DEBIAN_FRONTEND=noninteractive

# Add support for apt-* packages caching through "apt-cacher-ng"
ARG APTPROXY
RUN bash -c 'if [ -n "$APTPROXY" ]; then echo "Acquire::HTTP::Proxy \"http://$APTPROXY\";" > /etc/apt/apt.conf.d/01proxy; fi'

## Install dependencies
RUN apt-get update \
    && apt-get --no-install-recommends install -y vim-tiny \

    # Python system packages
    python python-pip python-dev \
    # PIP build dependencies
    gcc libssl-dev \

    && pip install -U pip 3to2 \

    # Cleanup after installation
    && apt-get clean -y \
    && apt-get autoclean -y \
    && apt-get autoremove -y \
    && rm -fr /var/lib/apt/lists/* \

    # Create basic project structure
    && mkdir -p /code/

WORKDIR /code

ADD project/requirements.txt requirements.txt
RUN pip install -r requirements.txt --no-cache-dir

EXPOSE 8000