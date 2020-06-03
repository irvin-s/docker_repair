FROM concretesolutions/ubuntu-dev  
  
# Install dependencies  
RUN apt-get update &&\  
apt-get -y install build-essential ruby1.9.1-dev libsqlite3-dev &&\  
apt-get clean && rm -rf /var/lib/apt/lists/*  
  
# Install mailcatcher  
RUN gem install mailcatcher --no-rdoc --no-ri  
  
CMD ["mailcatcher", "-f", "--ip=0.0.0.0"]  
  
# Expose mailcatcher http port  
EXPOSE 1025 1080  

