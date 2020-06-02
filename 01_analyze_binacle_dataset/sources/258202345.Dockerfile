FROM debian:sid
RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y gpg ca-certificates
RUN echo "deb http://repo.lngserv.ru/debian stretch main" | tee /etc/apt/sources.list.d/i2pd.list
RUN echo "deb-src http://repo.lngserv.ru/debian stretch main" | tee -a /etc/apt/sources.list.d/i2pd.list
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv 66F6C87B98EBCFE2 || \
    apt-key adv --keyserver pgp.mit.edu --recv-keys 66F6C87B98EBCFE2 || \
    apt-key adv --keyserver keyserver.ubuntu.com --recv 66F6C87B98EBCFE2 || \
    apt-key adv --keyserver keyserver.pgp.com --recv 66F6C87B98EBCFE2
RUN apt-get update && apt-get install -y i2pd procps
COPY etc/i2pd/tunnels.si-i2p-plugin.conf /etc/i2pd/tunnels.conf
COPY etc/i2pd/i2pd.si-i2p-plugin.conf /etc/i2pd/i2pd.conf
RUN chown -R i2pd:i2pd /var/lib/i2pd /var/log/i2pd
RUN chmod -R o+rw /var/lib/i2pd /var/log/i2pd
RUN ln -sf /usr/share/i2pd/certificates /var/lib/i2pd/certificates
RUN ln -sf /etc/i2pd/subscriptions.txt /var/lib/i2pd/subscriptions.txt
VOLUME /var/lib/i2pd
CMD service i2pd start; tail -f /var/log/i2pd/i2pd.log
