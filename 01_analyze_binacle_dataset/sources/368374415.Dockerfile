FROM gliderlabs/alpine

RUN apk --update add haproxy iptables supervisor irqbalance

ADD haproxy.cfg /etc/haproxy/haproxy.cfg
ADD haproxy.sh /haproxy.sh
ADD supervisord.conf /etc/supervisord.conf

RUN chmod a+x /haproxy.sh
RUN mkdir -p /var/run/haproxy /var/lib/haproxy
RUN chown -R haproxy:haproxy /var/run/haproxy /var/lib/haproxy

#RUN echo "* soft nofile 1048576" >> /etc/security/limits.conf
#RUN echo "* hard nofile 1048576" >> /etc/security/limits.conf

EXPOSE 80 443

CMD ["supervisord", "-n", "-c", "/etc/supervisord.conf"]
