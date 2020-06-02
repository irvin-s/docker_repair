FROM debian:jessie  
  
MAINTAINER Frank Fuhrmann, bitmuncher@mailbox.org  
  
RUN apt-get update && apt-get install -y libterm-readline-perl-perl  
RUN apt-get install -y nodejs-legacy \  
npm  
RUN apt-get clean  
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN npm install -g sinopia  
  
RUN useradd -ms /bin/bash sinopia  
  
RUN mkdir -p /home/sinopia/storage  
  
ADD config/start.sh /home/sinopia/start.sh  
ADD config/config.yaml /home/sinopia/config.yaml  
ADD config/htpasswd /home/sinopia/htpasswd  
  
RUN chown -R sinopia:sinopia /home/sinopia  
RUN chmod ug+rx /home/sinopia/start.sh  
  
USER sinopia  
WORKDIR /home/sinopia  
  
CMD ["/home/sinopia/start.sh"]  
  
EXPOSE 4873  

