FROM node:8.9.3

ENV PYTHON_PIP_VERSION 9.0.1
ENV AWS_CLI_VERSION 1.14.7
ENV CLOUD_SDK_VERSION 182.0.0
ENV WATCHMAN_VERSION 4.9.0
ENV DOCKER_VERSION 17.09.0~ce-0~debian
ENV DOCKER_COMPOSE_VERSION 1.17.0
ENV PATH /google-cloud-sdk/bin:$PATH
ENV GOOGLE_APPLICATION_CREDENTIALS /gcp-key.json

RUN set -ex; \
    apt-get update && apt-get install -y --no-install-recommends \
        apt-transport-https gnupg2 software-properties-common python-dev; \
    # Pip
    wget -O get-pip.py 'https://bootstrap.pypa.io/get-pip.py'; \
    python get-pip.py \
		--disable-pip-version-check \
		--no-cache-dir \
		"pip==$PYTHON_PIP_VERSION"; \
    pip --version; \
    find /usr/local -depth \
		\( \
			\( -type d -a \( -name test -o -name tests \) \) \
			-o \
			\( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
		\) -exec rm -rf '{}' +; \
	rm -f get-pip.py; \
    # AWS CLI
    pip install awscli==${AWS_CLI_VERSION}; \
    aws --version; \
    # Google Cloud SDK
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz; \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz; \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz; \
    ln -s /lib /lib64; \
    gcloud config set core/disable_usage_reporting true; \
    gcloud config set component_manager/disable_update_check true; \
    gcloud components install kubectl; \
    gcloud --version; \
    # Docker
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -; \
    apt-key fingerprint 0EBFCD88; \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable edge"; \
    apt-get update && apt-get install -y --no-install-recommends docker-ce=$DOCKER_VERSION; \
    docker --version; \
    # Docker Compose
    curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose; \
    chmod +x /usr/local/bin/docker-compose; \
    docker-compose --version; \
    # Watchman
    cd /tmp && curl -LO https://github.com/facebook/watchman/archive/v${WATCHMAN_VERSION}.tar.gz; \
    tar xzf v${WATCHMAN_VERSION}.tar.gz && rm v${WATCHMAN_VERSION}.tar.gz; \
    cd watchman-${WATCHMAN_VERSION}; \
    ./autogen.sh; ./configure; make; make install; \
    cd /tmp && rm -rf watchman-${WATCHMAN_VERSION}; \
    # Chrome dependencies
    # https://github.com/GoogleChrome/puppeteer/issues/290#issuecomment-322838700
    apt-get install -y --no-install-recommends gconf-service libasound2 libatk1.0-0 libc6 \
        libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 \
        libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 \
        libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 \
        libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation \
        libappindicator1 libnss3 lsb-release xdg-utils; \
    rm -r /var/lib/apt/lists/*;
