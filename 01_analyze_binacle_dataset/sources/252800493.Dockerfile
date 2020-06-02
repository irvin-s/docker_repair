FROM ubuntu  
ENV IDEA_HOME=$HOME/idea  
RUN mkdir ${IDEA_HOME}  
ADD idea/ $IDEA_HOME  
ADD docker-entrypoint.sh /  
COPY docker-entrypoint.sh /usr/local/bin/  
RUN chmod +x ${IDEA_HOME} -R  
RUN chmod +x docker-entrypoint.sh  
  
EXPOSE 1017  
WORKDIR $IDEA_HOME  
  
ENV USER dominate #default user  
  
CMD ["/docker-entrypoint.sh"]  

