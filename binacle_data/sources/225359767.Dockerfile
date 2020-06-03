FROM ubuntu:18.04
ARG VSN

RUN set -x \
 && apt update \
 && apt upgrade -y \
 && apt install -y \
        bind9-host \
        curl \
        dnsutils \
        dpkg \
        net-tools \
        python \
        sysstat \
 && export U="https://www.foundationdb.org/downloads/${VSN}/ubuntu/installers" \
 && curl -LO "${U}/foundationdb-clients_${VSN}-1_amd64.deb" \
 && curl -LO "${U}/foundationdb-server_${VSN}-1_amd64.deb" \
 && dpkg -i foundationdb-*.deb \
 && rm -f foundationdb-*.deb \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /var/lib/foundationdb/data/* \
 && rm -rf /var/log/foundationdb/* \ 
 && rm -rf /var/run/fdbmonitor.pid

COPY ./start-foundationdb.sh /start-foundationdb.sh
CMD ["bash", "/start-foundationdb.sh"]

