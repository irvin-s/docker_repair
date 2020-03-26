FROM desiato/archlinux  
  
RUN echo 'nobody:x:65534:65534:Nobody:/:/sbin/nologin' >> /etc/passwd && \  
echo 'nobody:x:::::::' >> /etc/shadow && \  
echo 'nobody:x:65534:' >> /etc/group && \  
echo 'nobody:::' >> /etc/gshadow && \  
useradd -r -u 196 -d /var/lib/gitolite gitolite && \  
pacman --noconfirm -Syu && \  
pacman --noconfirm -S gitolite sudo && \  
echo -e 'y\ny' | pacman -Scc && \  
rm -r /usr/share/man/* && \  
ls -d /usr/share/locale/* | egrep -v 'alias|en_US' | xargs rm -rf  
  
EXPOSE 2222  
VOLUME /var/lib/gitolite  
COPY start /usr/local/bin  
  
CMD start  

