FROM itscaro/debian-ssh

# My custom
WORKDIR /root/

RUN apt-get update && apt-get install m2crypto git vim  mtr vnstat supervisor curl wget cron screen -y 

RUN apt-get install iceweasel lxde-core lxterminal tightvncserver xrdp cpulimit htop -y

# install flash
RUN wget https://fpdownload.adobe.com/get/flashplayer/pdc/26.0.0.151/flash_player_npapi_linux.x86_64.tar.gz
RUN tar -zxf flash_player_*_linux.x86_64.tar.gz
RUN cp libflashplayer.so /usr/lib/mozilla/plugins/ && cp -r usr /usr


# download extra
RUN wget https://addons.mozilla.org/firefox/downloads/latest/vagex-firefox-add-on/addon-321174-latest.xpi \
&& wget https://www.ebesucher.com/data/firefoxaddon/latest.xpi \
&& wget https://addons.mozilla.org/firefox/downloads/latest/foxyproxy-standard/addon-2464-latest.xpi

RUN git clone -b manyuser https://github.com/shadowsocksr/shadowsocksr.git	

# xvnc server porst, if $DISPLAY=:1 port will be 5901	
EXPOSE 15900	


ADD scripts /root

RUN chmod a+x /root/*.sh  
RUN echo '*/1 * * * * root bash /root/check.sh' >> /etc/crontab
RUN echo '*/15 * * * * root bash /root/vnc.sh' >> /etc/crontab
RUN service cron restart


CMD    ["/usr/sbin/sshd", "-D"]
