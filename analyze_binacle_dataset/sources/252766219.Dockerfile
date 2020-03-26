FROM node  
MAINTAINER Alejandro Baez <https://twitter.com/a_baez>  
  
RUN git clone https://github.com/erming/shout.git /opt/shout  
  
WORKDIR /opt/shout  
RUN npm install -g  
  
EXPOSE 9000  
RUN mkdir /config  
VOLUME /config  
  
ENTRYPOINT ["shout", "--home", "/config"]  
  
CMD ["start"]  

