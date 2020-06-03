FROM jetty:alpine
# https://hub.docker.com/r/library/jetty/
# https://github.com/JornC/bitcoin-transaction-explorer
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.5/main" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.5/community" >> /etc/apk/repositories && \
    echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk upgrade --update
RUN apk --update --no-cache add bash curl jq git bitcoin==0.13.1-r0 bitcoin-cli==0.13.1-r0 bitcoin-tx==0.13.1-r0 openjdk8
#ADD bitcoin-transactions-server-0.1.war /var/lib/jetty/webapps/ROOT.war
ADD bitcoin-transactions-server-0.1.war /tmp/server.war
RUN mkdir /tmp/ROOT && cd /tmp/ROOT && jar -xvf /tmp/server.war
ADD yoghurt.conf /tmp/ROOT/WEB-INF/classes/yoghurt.conf
RUN cd /tmp/ROOT && jar -cvf ../ROOT.war * && mv /tmp/ROOT.war /var/lib/jetty/webapps/
RUN rm -rf /tmp/server.war /tmp/ROOT
ADD bitcoin.conf /root/.bitcoin/
ADD start.sh /
RUN chmod a+x /start.sh
