FROM debian:testing-slim  
ADD archive-key.asc /  
RUN apt-get -y update && apt-get -y install gnupg2  
RUN apt-key add /archive-key.asc  
RUN apt-get -y autoremove gnupg2  
  
ADD sources.list /etc/apt/  
  
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt*  
  

