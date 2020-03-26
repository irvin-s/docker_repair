FROM fedora:24  
MAINTAINER Andrae Findlator <andrae.findlator@gmail.com>  
  
RUN dnf update -y && dnf install -y vim php php-xml php-mbstring php-bcmath  
  
COPY ./ /Worker/  
COPY ./Code/ /Worker/Code/  
  
CMD ["/Worker/worker.php"]  
#ENTRYPOINT ["/usr/bin/php", "/Worker/worker.php"]  
#CMD ["journals"]  

