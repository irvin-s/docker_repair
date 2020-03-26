FROM birkhofflee/coffeeforever  
  
MAINTAINER Birkhoff Lee <admin@birkhoff.me>  
  
EXPOSE 1827  
RUN /build.sh BirkhoffLee AnonyPages  
CMD [ "/run.sh" ]  

