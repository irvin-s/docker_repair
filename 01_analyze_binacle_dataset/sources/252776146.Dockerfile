FROM ndslabs/cloud9-base:3.0  
  
#USER root  
#RUN useradd developer -c "NodeJS Developer"  
# Install NodeJS / NPM  
RUN apt-get -qq update && \  
apt-get -qq install npm && \  
ln -s /usr/bin/nodejs /usr/bin/node  
  
# Install Bower / Grunt / Gulp  
RUN npm install -g bower grunt gulp  
  
#USER developer  

