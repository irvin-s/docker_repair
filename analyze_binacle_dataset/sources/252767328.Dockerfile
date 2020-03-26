# alexindigo/private-npm  
FROM alexindigo/npm-registry-couchapp:2.4.3  
MAINTAINER Alex Indigo <iam@alexindigo.com>  
  
# Install npm-registry proxy  
RUN npm install -g kappa  
  
# Add init script  
ADD ./start.sh /start.sh  
  
# Create workspace  
# And bind it to the site folder at runtime  
VOLUME ["/www"]  
WORKDIR /www  
  
EXPOSE 80  
# init npm couchapp  
CMD ["/start.sh"]  

