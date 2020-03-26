FROM gcr.io/google-appengine/debian8  
  
ENV DEBIAN_FRONTEND=noninteractive  
  
ADD manage-startup-script.sh /  
RUN chmod +x /manage-startup-script.sh  
CMD /manage-startup-script.sh  

