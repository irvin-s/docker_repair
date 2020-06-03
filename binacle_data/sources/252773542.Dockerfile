FROM alpine:latest  
MAINTAINER billyplus "https://github.com/billyplus"  
#ENV USERNAME=billy  
#ENV PASSWD=root  
# Environments  
ENV TIMEZONE Asia/Shanghai  
  
# add entrypoint script  
COPY docker-entrypoint.sh /docker-entrypoint.sh  
  
RUN apk --update --no-cache add openssh git sudo bash && \  
apk add --update tzdata && \  
cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \  
echo "${TIMEZONE}" > /etc/timezone && \  
sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config && \  
#echo "root:root" | chpasswd && \  
echo "${TIMEZONE}" > /etc/TZ && \  
passwd -d root && \  
#adduser -D -s /bin/ash $USERNAME && \  
#passwd -u $USERNAME && \  
#echo "$USERNAME:$PASSWD" | chpasswd && \  
#chown -R $USERNAME:$USERNAME /home/$USERNAME && \  
rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key && \  
chmod 755 /docker-entrypoint.sh && \  
apk del tzdata && \  
rm -rf /var/cache/apk/*  
  
EXPOSE 22  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["/usr/sbin/sshd","-D", "-e"]

