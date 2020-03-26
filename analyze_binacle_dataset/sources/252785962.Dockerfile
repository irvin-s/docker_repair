FROM djsd123/moodlecsl  
MAINTAINER Mikael Allison <mikael.allison@digital.cabinet-office.gov.uk>  
  
CMD ["/usr/sbin/apachectl","-D","FOREGROUND"]

