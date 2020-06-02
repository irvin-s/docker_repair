FROM debian:stretch-slim

ARG VERSION
ENV KIBANA_VERSION=$VERSION

ENV NODEJS_VERSION 10.14.1
ENV LOGTRAIL_VERSION 0.1.31

RUN apt-get update -q && \
    apt-get install -q -y --no-install-recommends ca-certificates curl jq && \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install ${NODEJS_VERSION} && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "Downloading Kibana version $KIBANA_VERSION " && \
    curl -Lkj https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz | tar zx -C /opt && \
    mv /opt/kibana-${KIBANA_VERSION}-linux-x86_64 /opt/kibana && \
    rm -rf /opt/kibana/node && \
    mkdir -p /opt/kibana/node/bin && \
    ln -sf /root/.nvm/versions/node/v${NODEJS_VERSION}/bin/node /opt/kibana/node/bin/node

RUN LOGTRAIL_DL=$(curl -s https://api.github.com/repos/sivasamyk/logtrail/releases/latest | jq -r '.assets[] | select(.name | contains("${KIBANA_VERSION}")) | .browser_download_url') && \
    if [ -z ${LOGTRAIL_DL} ]; then \
        echo "Logtrail plugin still not released. Check https://github.com/sivasamyk/logtrail/releases"; \
    else \
        echo "Logtrail plugin exists, downloading: ${LOGTRAIL_DL}";  \
        /opt/kibana/bin/kibana-plugin install ${LOGTRAIL_DL}; \
    fi

ADD ./run.sh /run.sh

RUN /opt/kibana/bin/kibana --version

EXPOSE 5601

ENTRYPOINT /run.sh
