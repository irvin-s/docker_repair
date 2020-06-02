FROM crramirez/limesurvey:latest  
  
# Add the installation script to the container  
ADD install.sh /  
RUN chmod +x /install.sh  
  
# It would be nice to have this work but ¯\\_(ツ)_/¯  
# CMD ['install.sh']  

