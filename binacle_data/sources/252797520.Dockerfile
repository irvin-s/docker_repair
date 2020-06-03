FROM garland/butterfly  
  
RUN apt-get update && apt-get -y install bash vim byobu ssh nodejs npm  
  
CMD ["/opt/run.sh"]  

