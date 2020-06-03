FROM debian:jessie  
  
RUN apt-get update \  
&& apt-get install -y cowsay \  
&& apt-get clean  
  
ENTRYPOINT ["/usr/games/cowsay","-f","dragon"]  
CMD ["you're","awesome"]  

