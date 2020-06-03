FROM debian  
RUN apt update  
# for node  
RUN apt install -y gnupg2 curl  
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh  
RUN bash nodesource_setup.sh  
RUN rm nodesource_setup.sh  
RUN apt install -y nodejs  
RUN apt autoremove -y --purge gnupg2 curl  
  

