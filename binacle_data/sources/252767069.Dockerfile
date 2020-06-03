FROM node:4  
EXPOSE 9000  
RUN apt-get -yqq update && \  
apt-get -yqq install vim ruby-full  
  
RUN npm install -g bower -g grunt-cli -g karma-cli && \  
echo '{ "allow_root": true }' > /root/.bowerrc  
  
RUN gem install compass  
  
WORKDIR /var/www  
  
CMD ["bash"]  

