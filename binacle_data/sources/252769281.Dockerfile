FROM anilornd/nodezmq  
  
RUN apk add --update git  
  
ADD ./config/start.sh /home/  
  
RUN chmod u+x /home/start.sh  
  
CMD ["/home/start.sh"]

