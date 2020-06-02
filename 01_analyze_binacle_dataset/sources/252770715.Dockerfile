FROM fedora:25  
MAINTAINER Andrae Findlator <andrae.findlator@gmail.com>  
  
RUN dnf update -y && dnf install -y php php-xml php-mbstring  
  
COPY ./app /Worker/  
  
WORKDIR "/Worker"  
  
#ENTRYPOINT ["/Worker/dailysales.php"]  
CMD ["/Worker/dailysales.php"]  

