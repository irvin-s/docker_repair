FROM quay.io/democracyworks/oracle-jdk-7:latest  
MAINTAINER Democracy Works, Inc. <dev@turbovote.org>  
  
# install leiningen  
RUN wget https://raw.github.com/technomancy/leiningen/stable/bin/lein  
RUN mv lein /usr/local/bin  
RUN chmod a+x /usr/local/bin/lein  
ENV LEIN_ROOT 1 # disable warning about running lein as root  
RUN lein version # force download before adding project code  

