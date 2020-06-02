FROM vidiben/casperjs  
  
MAINTAINER Christian Blades <christian.blades@careerbuilder.com>  
  
WORKDIR /casper  
ONBUILD ADD . /casper  
  
ENTRYPOINT ["casperjs"]  
CMD ["script.js"]  

