FROM easyckan/easyckan:dev  
MAINTAINER Luiz Felipe F M Costa <luiz@thenets.org>  
  
ADD dadosabertos.sh /dadosabertos.sh  
  
CMD /dadosabertos.sh

