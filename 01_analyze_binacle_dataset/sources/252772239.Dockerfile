# Using eclipse/node  
FROM eclipse/node  
# install custom needed libraries  
RUN sudo apt-get update && \  
sudo apt-get -y install libpng-dev  
  
CMD tail -f /dev/null  

