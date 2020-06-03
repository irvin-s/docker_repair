FROM zerovpn-base:latest

ARG ip_base_prefix
ARG server_port

ADD authorized_keys openvpn-server.conf openvpn-client.conf \
      docker-entrypoint login-shell \
    /home/vpn/

RUN sed -ri 's/IP_BASE_PREFIX/'$ip_base_prefix'/g; \
             s/SERVER_PORT/'$server_port'/g' /home/vpn/* \
 && mv /home/vpn/openvpn-server.conf /etc/openvpn/server.conf \
 && mv /home/vpn/authorized_keys /home/vpn/.ssh/ \
 && mv /home/vpn/docker-entrypoint / \
 && chown vpn:vpn /home/vpn/.ssh/authorized_keys \
 && chsh -s /home/vpn/login-shell vpn \
 && chmod 0700 /home/vpn/.ssh/authorized_keys \
 && rm /etc/ssh/ssh_host_* \
 && dpkg-reconfigure openssh-server

EXPOSE 22
EXPOSE $server_port

CMD /docker-entrypoint
