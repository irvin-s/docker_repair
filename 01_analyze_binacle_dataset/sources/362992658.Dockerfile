FROM ubuntu:latest
#MAINTAINER Eric Windisch <eric@windisch.us>

RUN apt-get update; apt-get upgrade -y
RUN apt-get install -y quagga

RUN chown -R quagga /etc/quagga

COPY quagga-init /usr/local/bin/

# Expose ports that quagga, BGP use (179 is bgp, rest are quagga mngmt)
EXPOSE 179 2601 2602 2603 2604 2605

# enable daemons
RUN sed -i 's/bgpd=no/bgpd=yes/g' /etc/quagga/daemons
RUN sed -i 's/zebra=no/zebra=yes/g' /etc/quagga/daemons
RUN sed -i 's/vtysh=no/vtysh=yes/g' /etc/quagga/daemons

ENV PATH "/usr/lib/quagga/:/sbin:/bin:/usr/sbin:/usr/bin"
ENTRYPOINT ["/bin/bash", "-er", "/usr/local/bin/quagga-init"]

# For building dependent images with baked-in config.
# copy the default configs for the routing daemons
ADD bgpd.conf /etc/quagga/bgpd.conf
#ADD conf/babeld.conf /etc/quagga/babeld.conf
ADD zebra.conf /etc/quagga/zebra.conf
ADD vtysh.conf /etc/quagga/vtysh.conf
RUN chown -R quagga /etc/quagga
