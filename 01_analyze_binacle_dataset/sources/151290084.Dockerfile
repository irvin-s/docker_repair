# Firefox over VNC

FROM silarsis/ssh-server
MAINTAINER Kevin Littlejon <kevin@littlejohn.id.au>

# Install vnc, xvfb in order to create a 'fake' display
RUN apt-get install -yq x11vnc xvfb vim xdm xpra rox-filer pwgen xserver-xephyr fluxbox

# Configuring xdm to allow connections from any IP address and ssh to allow X11 Forwarding. 
RUN sed -i 's/DisplayManager.requestPort/!DisplayManager.requestPort/g' /etc/X11/xdm/xdm-config
RUN sed -i '/#any host/c\*' /etc/X11/xdm/Xaccess
RUN ln -s /usr/bin/Xorg /usr/bin/X
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config

# Upstart and DBus have issues inside docker.
RUN dpkg-divert --local --rename --add /sbin/initctl && rm -f /sbin/initctl && ln -s /bin/true /sbin/initctl

# Add a user to run under
RUN chmod go+w,u+s /tmp
RUN adduser --disabled-password --gecos "" silarsis \
  && echo "silarsis ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
  && echo 'silarsis:passwd' | chpasswd
RUN echo '/home/silarsis/docker-desktop' >> /home/silarsis/.bashrc

ADD . /opt/docker-src

# Note, we only ever run one copy of this...
EXPOSE 22
CMD ["/opt/docker-src/startup.sh"]