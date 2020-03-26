FROM debian:jessie

RUN apt-get update && apt-get install -y -q gcc binutils make supervisor

ADD softether-vpnserver-v4.06-9437-beta-2014.04.09-linux-x64-64bit.tar.gz /opt/

RUN cd /opt/vpnserver && make i_read_and_agree_the_license_agreement
ADD supervisord.conf /etc/supervisor/supervisord.conf

VOLUME /usr/local/vpnserver/

ENV PATH /opt/vpnserver/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ADD admin.sh /opt/vpnserver/vpnadmin
RUN chmod +x /opt/vpnserver/vpnadmin

EXPOSE 443/tcp 992/tcp 1194/tcp 1194/udp 5555/tcp

CMD ["supervisord"]
