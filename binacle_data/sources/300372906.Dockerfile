#
# An Alpine-based dnsmasq + OpenVPN Docker image that forwards DNS requests with
# kubernetes domain suffixes (.cluster.<cluster-name>) to the appropriate
# kube-dns instances.
# In other words it allows seamless access to all your Kubernetes services, by
# DNS name + kubectl access, through the OpenVPN client running on this image.
#
# A note for haters: I know, running two processes in one Docker image ISN'T a
# good practice at all. If docker had pods like rkt does, I would definitely
# have shipped two containers. However, it doesn't therefore I went for the much
# simpler & dirty way: running both the dnsmasq & OpenVPN processes in the same
# container, despite the high risk of loosing my place in Heaven :(
#
# Maintainer: Étienne Lafarge <etienne.lafarge@gmail.com>
#
FROM alpine:latest
MAINTAINER Étienne Lafarge <etienne@rythm.co>

RUN apk add --update openvpn dnsmasq && rm -rf /var/cache/apk/*

ADD ./dnsmasq.conf /etc/dnsmasq.conf
ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["openvpn", "--config", "/etc/openvpn/client.conf"]
