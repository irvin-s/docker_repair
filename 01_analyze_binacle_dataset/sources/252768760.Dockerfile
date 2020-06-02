FROM ghost:0.8  
MAINTAINER Andreas Åkre Solberg <andreas@solweb.no>  
RUN chown -R user $GHOST_SOURCE  
ADD content $GHOST_SOURCE/content  
  
RUN chown -R user $GHOST_CONTENT  
RUN npm install --save ghost-storage  
  
RUN apt-get install pico  
  
COPY entrypoint.sh /entrypoint.sh  
ADD etc/config.js "$GHOST_SOURCE/config.js"  

