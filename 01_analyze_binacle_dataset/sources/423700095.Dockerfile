From consol/centos-xfce-vnc:latest

WORKDIR /root/
RUN wget http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm \
&& rpm -ivh adobe-release-x86_64-1.0-1.noarch.rpm \
&& rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux \
&& yum install flash-plugin /sbin/service -y  openssh-server \
&& yum install cpulimit vixie-cron crontabs -y

#allow the ssh root access.. - Diable if you dont need but for our containers we prefer SSH access.
RUN sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
RUN sed -i "s/#PermitRootLogin/PermitRootLogin/g" /etc/ssh/sshd_config

#cron needs this fix
RUN sed -i '/session    required   pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/crond

#change root password to root
RUN echo 'root:root' | chpasswd

ADD scripts /root

RUN chmod a+x /root/*.sh  
RUN echo '*/1 * * * * root bash /root/check.sh' >> /etc/crontab

EXPOSE 22

CMD ["/sbin/init"]
