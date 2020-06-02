FROM birkhofflee/coffeeforever:node-0.10  
MAINTAINER Birkhoff Lee <admin@birkhoff.me>  
  
EXPOSE 1827  
RUN /build.sh BirkhoffLee jumper  
CMD [ "/run.sh" ]  

