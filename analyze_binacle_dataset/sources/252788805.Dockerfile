FROM ruby:2.5.1  
  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash && \  
apt-get update && \  
apt-get install -y libqt4-dev libqtwebkit-dev nodejs && \  
apt-get clean  

