FROM ubuntu:14.04  
RUN apt-get install -y curl && curl -sSL https://get.docker.com/ | sh  
  
ADD files/main.pl /main.pl  
  
ENTRYPOINT [ "perl", "./main.pl" ]  

