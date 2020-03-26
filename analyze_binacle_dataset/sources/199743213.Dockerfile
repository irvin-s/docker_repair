FROM debian:stable-slim

ENV PYTHONUNBUFFERED=1 DOCKER=1 DEBIAN_FRONTEND=noninteractive

# Add support for apt-* packages caching through "apt-cacher-ng"
ARG APTPROXY
RUN bash -c 'if [ -n "$APTPROXY" ]; then echo "Acquire::HTTP::Proxy \"http://$APTPROXY\";" > /etc/apt/apt.conf.d/01proxy; fi'

## Install dependencies
RUN apt-get update \
    && apt-get --no-install-recommends install -y vim-tiny \

    # Install latest NodeJS + NPM
    && apt-get --no-install-recommends install -y curl ca-certificates apt-transport-https lsb-release \
    && curl -sSL https://deb.nodesource.com/setup_7.x | bash - \
    && apt-get --no-install-recommends install -y nodejs \

    # Install global NPM packages
    && npm install -g webpack \

    # Python system packages
    && apt-get --no-install-recommends install -y python python-pip python-dev \
    # PIP build dependencies
    gcc libssl-dev \

    && pip install -U pip 3to2 \

    # System stuff
    && apt-get --no-install-recommends install -y nginx-extras \

    # Cleanup after installation
    && npm cache clear \
    && rm -rf /tmp/npm-* \
    && apt-get clean -y \
    && apt-get autoclean -y \
    && apt-get autoremove -y \
    && rm -fr /var/lib/apt/lists/* \

    # Create basic project structure
    && mkdir -p /app/project/assets/ /app/logs /app/tmp/

WORKDIR /app/

# Add packages.json (NPM) & requirements.txt (PIP) files to the image
ADD project/requirements.txt /app/requirements.txt
ADD project/assets/package.json /app/project/assets/package.json

# Install NPM & Python dependencies
RUN pip install -U -r /app/requirements.txt --no-cache-dir
RUN cd /app/project/assets/ \
    && npm install \
    && npm cache clear

ADD . /app/

RUN cd /app/project/assets/ \
    && npm run build
RUN python manage.py collectstatic --noinput -v0

ADD docker/production/nginx/nginx.conf /etc/nginx/sites-enabled/project
ADD docker/production/nginx/conf.d/* /etc/nginx/conf.d/

EXPOSE 80