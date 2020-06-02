FROM ubuntu:18.04
LABEL maintainer="Gigantum <support@gigantum.com>"

# Copy requirements.txt files
COPY resources/awful-intersections-demo.lbk /opt/awful-intersections-demo.lbk
COPY packages/gtmcore/requirements.txt /opt/gtmcore/requirements.txt
COPY packages/gtmcore/requirements-testing.txt /opt/gtmcore/requirements-testing.txt
COPY packages/gtmapi/requirements.txt /opt/gtmapi/requirements.txt
COPY packages/gtmapi/requirements-testing.txt /opt/gtmapi/requirements-testing.txt
COPY packages/confhttpproxy /opt/confhttpproxy
ENV SHELL=/bin/bash

# Install system level dependencies
RUN apt-get -y update && \
    apt-get -y --no-install-recommends install git nginx supervisor wget openssl python3 python3-pip python3-distutils \
    gcc g++ gosu redis-server libjpeg-dev git-lfs python3-setuptools python3-dev libdpkg-perl ssh zip unzip libsnappy-dev && \
    git lfs install && \
    apt-get -y install curl gnupg gnupg1 gnupg2 && \
    curl -sL https://deb.nodesource.com/setup_11.x | bash && \
    apt-get -y install nodejs && \
    npm install -g configurable-http-proxy && \
    cd /opt/confhttpproxy && pip3 install . && \
    pip3 install wheel && \
    pip3 install -r /opt/gtmcore/requirements.txt && \
    pip3 install -r /opt/gtmapi/requirements.txt && \
    pip3 install -r /opt/gtmcore/requirements-testing.txt && \
    pip3 install -r /opt/gtmapi/requirements-testing.txt && \
    pip3 install codecov pytest-cov pytest-xdist && \
    apt-get -qq -y remove gcc g++ python3-dev wget gnupg gnupg1 gnupg2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log

# Setup circleci user
RUN useradd -ms /bin/bash circleci

# Install jest for UI tests
RUN npm install -g @babel/cli@7.2.3 @babel/core@7.2.2 jest@23.6.0 relay-compiler@2.0.0

# Install fossa
RUN curl -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/fossas/fossa-cli/master/install.sh | bash

# Set up working dir, required for import mocks
RUN mkdir -p /mnt/gigantum && chown -R circleci:circleci /mnt/gigantum && \
    mkdir /home/circleci/gigantum && chown -R circleci:circleci /home/circleci/gigantum && \
    mkdir /mnt/share && chown -R circleci:circleci /mnt/share && \
    mkdir /opt/redis && chown -R circleci:circleci /opt/redis

# Setup gtmcore config file - should be written by automation before copy
COPY build/circleci/labmanager.yaml /etc/gigantum/labmanager.yaml

# Finish setting up user
USER circleci
WORKDIR /home/circleci

# Setup git
RUN git config --global user.email "noreply@gigantum.io" && \
    git config --global user.name "CircleCI" && \
    git config --global credential.helper store

CMD ["/bin/bash"]
