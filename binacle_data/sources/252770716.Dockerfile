FROM fedora:24  
MAINTAINER Andrae Findlator  
  
RUN dnf update -y && dnf install -y vim php php-mssql php-mysql php-xml  
  
COPY ./ /Worker/  
COPY ./Code/ /Worker/Code/  
  
ENTRYPOINT ["/usr/bin/php", "/Worker/worker.php"]  
CMD ["journals"]  
  

