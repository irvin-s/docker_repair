FROM beilber/steamcmd  
  
ADD wrapper.sh /wrapper  
ADD validate.sh /validate.sh  
  
RUN \  
chmod +x /wrapper  
  
VOLUME ["/root/steamcmd/appdir"]  
  
ENTRYPOINT ["/wrapper"]  
  
# Expose ports.  
EXPOSE 28015  

