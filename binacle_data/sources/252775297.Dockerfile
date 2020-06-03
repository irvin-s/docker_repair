FROM beevelop/ruby:2.2  
  
ENV SUPPLY_VERSION=0.5.2  
  
RUN apt-get -qq update && apt-get -qq install -y less build-essential && \  
gem install supply:$SUPPLY_VERSION && \  
apt-get remove -y build-essential && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \  
apt-get autoremove -y && apt-get clean  

