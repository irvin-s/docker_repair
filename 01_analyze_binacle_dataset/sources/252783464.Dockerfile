FROM debitux/devuan:testing  
  
ENV UN dev  
ENV PW qwerty  
ENV TERM xterm  
  
COPY files/runRDP.sh /runRDP.sh  
  
RUN \  
apt-get update && \  
apt-get -y upgrade && \  
apt-get -y dist-upgrade && \  
apt-get -y install sudo git eterm openbox vnc4server xfonts-base \  
xrdp xterm git fish terminator vim --no-install-recommends && \  
apt-get -y -q autoclean && apt-get -y -q autoremove &&\  
apt-get -y clean && \  
rm -rf /var/lib/apt/lists/* \  
/usr/share/doc /usr/share/doc-base \  
/usr/share/man /usr/share/locale /usr/share/zoneinfo  
  
RUN \  
useradd -m --user-group --shell /usr/bin/fish $UN && \  
echo "$UN:$PW" | chpasswd && \  
echo "$UN ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$UN && \  
chmod 0440 /etc/sudoers.d/$UN && \  
echo "exec openbox-session" > /home/$UN/.xsession && \  
chown $UN:$UN /home/$UN/.xsession && \  
chown -R $UN:$UN /home/$UN/ && \  
mkdir -p /usr/share/doc/xrdp/ && \  
service xrdp start && \  
service xrdp stop && \  
rm /var/run/xrdp/*.pid  
  
WORKDIR /home/$UN/repo  
WORKDIR /home/$UN  
  
CMD ["/runRDP.sh"]  

