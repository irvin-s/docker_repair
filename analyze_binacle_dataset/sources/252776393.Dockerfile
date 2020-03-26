# http://docs.docker.com/reference/builder  
# Source broadcast proxy image (boombatower/source-broadcast-proxy).  
FROM boombatower/opensuse  
MAINTAINER Jimmy Berry <jimmy@boombatower.com>  
  
# Install software:  
RUN zypper -n install --no-recommends \  
php5 php5-json php5-sockets  
  
# Runtime configuration.  
USER wwwrun  
WORKDIR /srv  
ENTRYPOINT ["/usr/bin/php" , "proxy.php"]  
  
EXPOSE 27015/udp  
  
# Add code last so that rebuilding to pick up changes is fast.  
ADD . /srv  

