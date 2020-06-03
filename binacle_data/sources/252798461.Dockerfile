FROM ruby:2.4.0  
# Install RPM for rpm builds  
RUN apt-get update && apt-get install -y rpm  
  
# Install FPM  
RUN gem install --no-rdoc --no-ri fpm  
  
# Define working directory  
WORKDIR /data  
  
# Define default command  
CMD ["bash"]  

