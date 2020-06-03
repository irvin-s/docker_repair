FROM mailgun/vulcand:v0.8.0-beta.2  
ADD launch_vulcand.sh /usr/local/bin/  
  
ENTRYPOINT "launch_vulcand.sh"  

