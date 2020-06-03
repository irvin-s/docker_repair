FROM cook/hhvm:3.10  
RUN groupadd -r alpha \  
&& useradd -r -g alpha -G sudo alpha  
  
CMD ["hhvm", "--mode", "server"]  
  
VOLUME ["/var/log/hhvm","/home/alpha","/var/run/hhvm/repo"]

