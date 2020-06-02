FROM xeor/base-centos

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2015-10-07

# Crashplan itself (at least as much as we can. It generates some ID's at install)
RUN yum upgrade -y && yum install -y tar && curl -L https://download2.code42.com/installs/linux/install/CrashPlan/CrashPlan_4.4.1_Linux.tgz | tar -zx && \
    cd /crashplan-install && \
    sed -i 's/^more /: /g' install.sh && \
    (echo; echo; echo yes; echo ; echo y; echo; echo /backups; echo y; echo; echo; echo y; echo) | ./install.sh && \
    sleep 10 && \
    sed -i 's/<serviceHost>127.0.0.1<\/serviceHost>/<serviceHost>0.0.0.0<\/serviceHost>/g' /usr/local/crashplan/conf/my.service.xml

# Stuff needed for gui/vnc
ENV SCREEN_WIDTH 1200
ENV SCREEN_HEIGHT 960
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0
RUN yum install -y xorg-x11-server-Xvfb x11vnc gtk2 xorg-x11-fonts-*

COPY init/ /init/

VOLUME ["/data"]
VOLUME ["/backups"]

EXPOSE 4242
EXPOSE 4243
EXPOSE 5900
