FROM wernight/phantomjs:2
MAINTAINER tess@deninet.com

USER root

ADD https://github.com/jcalderonzumba/gastonjs/archive/v1.0.2.zip /tmp/gastonjs.zip

RUN mkdir -m 775 /data && \
    cd /tmp && \
    apt-get update && \
    apt-get install -y zip && \
    unzip gastonjs.zip && \
    mv gastonjs-1.0.2 /data/gastonjs && \
    chown -R phantomjs /data

USER phantomjs

EXPOSE 8510

CMD ["/usr/local/bin/phantomjs", "--ssl-protocol=any", "--ignore-ssl-errors=true", "/data/gastonjs/src/Client/main.js", "8510", "1024", "768"]
