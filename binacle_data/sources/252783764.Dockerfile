FROM debian:testing-slim  
MAINTAINER martin scharm  
  
RUN apt-get update \  
&& apt-get install -y moon-buggy \  
&& rm -rf /var/lib/apt/lists/*  
  
ENTRYPOINT ["/usr/games/moon-buggy"]  
  

