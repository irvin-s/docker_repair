FROM aharnum/universal  
  
COPY modify_preferences.sh /usr/local/bin/modify_preferences.sh  
COPY start.sh /usr/local/bin/start.sh  
  
RUN chmod 755 /usr/local/bin/modify_preferences.sh  
RUN chmod 755 /usr/local/bin/start.sh  
  
EXPOSE 8082  
ENTRYPOINT ["/usr/local/bin/start.sh"]  

