FROM boardiq/java7  
MAINTAINER BoardIQ <tech@boardintelligence.co.uk>  
  
RUN curl -s https://raw.github.com/technomancy/leiningen/stable/bin/lein > \  
/usr/local/bin/lein && \  
chmod 0755 /usr/local/bin/lein  

