FROM andyshinn/dnsmasq
COPY google-hosts/dnsmasq.conf /etc/dnsmasq.conf
COPY google-hosts/dnsmasq.hosts /etc/dnsmasq.hosts
COPY google-hosts/resolv.dnsmasq.conf /etc/resolv.dnsmasq.conf
