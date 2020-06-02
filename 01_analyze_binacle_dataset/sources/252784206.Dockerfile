FROM birkhofflee/coffeeforever:node-0.10  
MAINTAINER Birkhoff Lee <admin@birkhoff.me>  
  
EXPOSE 1827  
RUN /build.sh BirkhoffLee pfc_calculator  
CMD [ "/run.sh" ]

