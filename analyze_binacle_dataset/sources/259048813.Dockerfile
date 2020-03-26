# squid-net-speeder

FROM ubuntu:14.04.3
MAINTAINER malaohu <tua@live.cn>
RUN apt-get update && \
	apt-get clean  && \
	apt-get install libnet1 libpcap0.8  && \
	apt-get clean  && \
	apt-get install -y libnet1-dev libpcap0.8-dev && \
	apt-get clean  && \
    apt-get install -y git squid3 && \
	apt-get clean  && \
    mv /etc/squid3/squid.conf /etc/squid3/squid.conf.dist && \
    apt-get clean

ADD squid.conf /etc/squid3/squid.conf
RUN mkdir /var/cache/squid
RUN chown -R proxy:proxy /var/cache/squid
RUN /usr/sbin/squid3 -N -z -F


RUN git clone https://github.com/snooda/net-speeder.git net-speeder
WORKDIR net-speeder
RUN sh build.sh

RUN mv net_speeder /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/net_speeder

EXPOSE 3128

# Configure container to run as an executable
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]