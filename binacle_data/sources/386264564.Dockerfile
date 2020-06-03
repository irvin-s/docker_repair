# Docker image of simple VNC server
# ---------------------------------------------------
 
FROM            fedora
MAINTAINER      Misho Krastev <misho.kr@gmail.com>

# Install sshd, vnc and X server packages
RUN yum install -y openssh-server openssh-clients \
                   xorg-x11-xauth xorg-x11-fonts-* \
                   http://download.skype.com/linux/skype-4.3.0.37-fedora.i586.rpm

# Setup SSH Server ---------
RUN /usr/sbin/sshd-keygen
RUN mkdir /root/.ssh

ADD skype-client-key.pub /root/.ssh/authorized_keys
RUN chown root:root /root/.ssh/authorized_keys && chmod 600 /root/.ssh/authorized_keys

# SSH port for incoming connections
EXPOSE 22

CMD [ "/usr/sbin/sshd", "-D" ]

# ---------------------------------------------------
# eof
