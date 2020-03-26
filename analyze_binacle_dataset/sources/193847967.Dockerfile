# KaveToolbox 3.7-Beta on centos 7
FROM kave/kavetoolbox:3.7-Beta.c7.node
MAINTAINER KAVE <kave@kpmg.com>
RUN yum clean all

# hack linux version detection for windows builds (docker inconsistent!)
RUN rm -f /opt/KaveToolbox/pro
RUN mv /opt/KaveToolbox/3.7-Beta /opt/KaveToolbox_tmp
RUN rm -rf /opt/KaveToolbox
RUN sed -i 's/return output$/return "Centos7"\n/' /opt/KaveToolbox_tmp/config/kaveinstall.py 
RUN /opt/KaveToolbox_tmp/scripts/KaveInstall
RUN rm  -rf /opt/KaveToolbox_tmp

