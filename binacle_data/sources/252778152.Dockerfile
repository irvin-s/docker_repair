FROM appointmentguru/doctl:latest  
  
COPY floating-ip.sh .  
  
RUN chmod +x floating-ip.sh  
  
ENTRYPOINT ./floating-ip.sh  

