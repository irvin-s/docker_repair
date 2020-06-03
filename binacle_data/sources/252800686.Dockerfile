FROM doomspork/ruby-base  
MAINTAINER Sean Callan (@doomspork)  
RUN apt-get -y install redis-server  
EXPOSE 6379  
ENTRYPOINT [ '/usr/bin/redis-server' ]  

