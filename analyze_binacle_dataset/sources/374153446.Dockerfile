FROM haproxy:1.5
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

# todo: The container is exiting right away. Find out why
CMD ["haproxy", "-db",  "-f", "/usr/local/etc/haproxy/haproxy.cfg"]