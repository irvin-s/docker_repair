FROM bennyli/app-base  
LABEL maintainer="Benny Li <dev@benny-li.de>"  
  
USER root  
  
RUN apt-get update && apt-get install --yes \  
openssl \  
ca-certificates \  
offlineimap \  
fish  
  
COPY entrypoint.sh /entrypoint.sh  
RUN chmod ugo+x /entrypoint.sh  
  
USER $APP_USER  
RUN mkdir ~/.mail  
  
ENTRYPOINT ["/entrypoint.sh"]  

