FROM alpine  
RUN apk update && \  
apk add bash util-linux  
  
ADD startup-script.sh /  
RUN chmod +x startup-script.sh  
  
ADD update_hosts_file.sh /  
RUN chmod +x update_hosts_file.sh  
  
CMD /startup-script.sh  

