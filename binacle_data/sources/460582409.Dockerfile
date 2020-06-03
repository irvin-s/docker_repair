FROM python:2
MAINTAINER Phyks <phyks@phyks.me>

# Setup layout.
RUN useradd -d /home/user -m -s /bin/bash -U user

# Install OS dependencies.
RUN apt-get update && \
    apt-get install -y git libffi-dev \
    libxml2-dev libxslt-dev libyaml-dev libtiff-dev libjpeg-dev zlib1g-dev \
    libfreetype6-dev libwebp-dev build-essential gcc g++ wget;

# Install latest pip and python dependencies.
RUN pip install -U setuptools && \
    pip install html2text simplejson BeautifulSoup

# Install node.js.
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs

# Install weboob's code itself.
RUN git clone --depth 1 https://git.weboob.org/weboob/devel /home/user/weboob \
    && cd /home/user/weboob \
    && pip install .

RUN mkdir -p /flatisfy/data
VOLUME /flatisfy

COPY ./*.sh /home/user/

# Install Flatisfy, set up directories and permissions.
RUN cd /home/user \
    && git clone https://framagit.org/phyks/Flatisfy/ ./app \
    && cd ./app \
    && pip install -r requirements.txt \
    && npm install \
    && npm run build:prod \
    && mkdir -p /home/user/.local/share/flatisfy \
    && chown user:user -R /home/user \
    && chmod +x /home/user/*.sh

# Run server.
EXPOSE 8080
ENTRYPOINT ["/home/user/entrypoint.sh"]
CMD ["/home/user/run.sh"]
