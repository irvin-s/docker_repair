# http://docs.docker.com/reference/builder  
# openvpn route self image (boombatower/openvpn-route-self).  
FROM boombatower/opensuse  
MAINTAINER Jimmy Berry <jimmy@boombatower.com>  
  
ADD route-self.sh /root/bin/  
RUN chmod +x /root/bin/route-self.sh  
  
ENTRYPOINT ["/root/bin/route-self.sh"]  

