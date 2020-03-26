# http://docs.docker.com/reference/builder  
# Source Server Fake image (boombatower/source-server-fake).  
FROM boombatower/opensuse  
MAINTAINER Jimmy Berry <jimmy@boombatower.com>  
  
# Install software:  
RUN zypper -n install --no-recommends \  
php5 php5-sockets  
  
# Runtime configuration.  
USER wwwrun  
WORKDIR /srv  
ENTRYPOINT ["/usr/bin/php" , "fake.php"]  
  
EXPOSE 27015/udp  
  
# Add fake code last so that rebuilding to pick up changes is fast.  
ADD . /srv  

