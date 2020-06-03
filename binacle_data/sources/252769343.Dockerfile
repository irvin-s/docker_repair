FROM base/archlinux  
LABEL maintainer="anklebiter87@gmail.com"  
  
# Add openvpn  
RUN pacman -Syuq --noconfirm && pacman -S --noconfirm openvpn iptables  
  
# Create the volume to read vpn config  
VOLUME "/etc/openvpn"  
  
COPY run.sh /usr/bin  
  
# Give run the execute flag  
RUN chmod 755 /usr/bin/run.sh  
  
ENTRYPOINT /usr/bin/run.sh  

