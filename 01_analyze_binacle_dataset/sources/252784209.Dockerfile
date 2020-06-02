FROM birkhofflee/coffeeforever:node-0.10  
MAINTAINER Birkhoff Lee <admin@birkhoff.me>  
  
EXPOSE 1828  
RUN /build.sh BirkhoffLee Telegram-Warning-Bot  
CMD [ "/run.sh" ]  

