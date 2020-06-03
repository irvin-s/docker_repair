FROM ubuntu:bionic  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update && apt-get install -y sudo && \  
adduser --disabled-password --shell /bin/bash --gecos '' desktop && \  
echo "desktop ALL = NOPASSWD: ALL" > /etc/sudoers.d/desktop  
COPY conf_keyboard.txt /etc/default/keyboard  
RUN apt-get update && apt-get install -y x11-apps xpra dbus dbus-x11 && \  
mkdir /var/run/dbus && \  
echo "export XPRA_SOCKET_HOSTNAME=display" >> /etc/profile && \  
mkdir /var/run/xpra && \  
chmod 777 /var/run/xpra && \  
cat /etc/xpra/xpra.conf | sed -e 's/^mmap *= *yes/mmap = no/' \  
-e 's/^socket-permissions *= *.*$/socket-permissions = 666/' \  
-e 's/^sharing *= *no/sharing = yes/' -e 's/^log-file *= *.*$/log-file = \$DISPLAY.log/' \  
-e '$ a socket-dir = /var/run/xpra' \  
| tee /etc/xpra/xpra.conf > /dev/null  
  
RUN apt-get update && apt-get install -y vim unzip xdotool xmlstarlet  
  
RUN echo "export CONTAINER_LABEL=headless_desktop" >> /etc/profile && \  
echo "export PATH=$PATH:/usr/scripts" >> ~desktop/.profile  
  
VOLUME /var/run/xpra  
  
COPY scripts/*.sh /usr/scripts/  
RUN chmod -R +x /usr/scripts  
  
ENTRYPOINT [ "/usr/scripts/exec.sh" ]

