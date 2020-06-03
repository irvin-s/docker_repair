#
#  vim:ts=2:sw=2:et
#

FROM alpine:3.2
MAINTAINER Rohith <gambol99@gmail.com>

ADD https://github.com/UKHomeOffice/openvpn-authd/releases/download/v0.0.1/openvpn-authd_0.0.1_linux_x86_64.gz /opt/bin/openvpn-authd
ADD templates/ /opt/bin/templates
RUN chmod +x /opt/bin/openvpn-authd

WORKDIR "/opt/bin"

ENTRYPOINT [ "/opt/bin/openvpn-authd" ]
