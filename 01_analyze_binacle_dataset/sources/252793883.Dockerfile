FROM emby/embyserver:latest  
  
RUN echo $'\n\  
\x23 Ensure the ssl group exists with the same GID as on the host\n\  
if ! getent group 1001 > /dev/null; then\n\  
groupadd -f -g 1001 ssl\n\  
fi\n\  
\n\  
\x23 Ensure the emby user is in the ssl group\n\  
if ! (id -Gn emby | grep "\\bssl\\b") then\n\  
usermod -a -G ssl emby\n\  
fi\n'\  
>> /etc/cont-init.d/02-user-onetime  

