# Docker image of simple VNC server
# ---------------------------------------------------
 
FROM            fedora
MAINTAINER      Misho Krastev <misho.kr@gmail.com>

# Install sshd, vnc and X server packages
RUN yum install -y supervisor openssh-server
RUN yum install -y x11vnc openbox fbpanel xorg-x11-server-utils xterm dejavu-sans-fonts dejavu-serif-fonts

# Setup SSH Server ---------
RUN /usr/sbin/sshd-keygen
RUN mkdir /root/.ssh

ADD vnc-server-key.pub /root/.ssh/authorized_keys
RUN chown root:root /root/.ssh/authorized_keys && chmod 600 /root/.ssh/authorized_keys

# Setup minimal X server -----
ADD openbox.autostart /.config/openbox/autostart
ADD openbox.rc.xml /.config/openbox/rc.xml

RUN mkdir /.config/fbpanel && cp /usr/share/fbpanel/default /.config/fbpanel/default

# Configure supervisord -----
ADD supervisord.conf /etc/
ADD supervisor.xvfb.conf /etc/supervisord.d/
ADD supervisor.x11vnc.conf /etc/supervisord.d/
ADD supervisor.sshd.conf /etc/supervisord.d/
 
# SSH port, no direct connections to VNC server
EXPOSE 22

CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]

# ENV LC_ALL      en_US.UTF-8

# ---------------------------------------------------
# eof
