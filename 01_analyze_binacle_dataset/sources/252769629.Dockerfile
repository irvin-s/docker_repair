FROM python  
MAINTAINER Ariel Gerardo Rios <ariel.gerardo.rios@gmail.com>  
  
RUN ["mkdir", "-p", "/srv/ml-st-1"]  
VOLUME ["/srv/ml-st-1"]  
  
ADD [".", "/srv/ml-st-1"]  
  
WORKDIR /srv/ml-st-1  
RUN ["pip", "install", "-r", "requirements.txt"]  
  
EXPOSE 5000  
ENTRYPOINT ["./init.sh"]  

