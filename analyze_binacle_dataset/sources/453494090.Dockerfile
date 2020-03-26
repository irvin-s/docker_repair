FROM brokertron/centos:7
MAINTAINER Castedo Ellerman <castedo@castedo.com>

RUN yum install -y supervisor
RUN yum install -y tigervnc-server-minimal
RUN yum install -y glibc xkeyboard-config xorg-x11-server-Xvfb xorg-x11-fonts-Type1 ttmkfdir gsettings-desktop-schemas
RUN yum install -y ca-certificates java-openjdk
RUN yum install -y nmap-ncat
RUN yum install -y ibgateway

# 4001 = IB API
# 5900 = VNC
EXPOSE 4001 5900

COPY supervisord.conf /etc/supervisord.conf
COPY run-ibgateway /usr/bin/run-ibgateway

# set an empty VNC password
RUN echo | vncpasswd -f > /etc/vnc-passwd

COPY enter-gateway /root/enter-gateway
ENTRYPOINT ["/root/enter-gateway"]

