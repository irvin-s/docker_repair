# alexindigo/browse-npm  
FROM alexindigo/node-dev:0.10.29  
MAINTAINER Alex Indigo <iam@alexindigo.com>  
  
# Don't install browsenpm,  
# but allow it to be mounted from outside  
# Custom versions FTW  
# Add init script  
ADD ./start.sh /start.sh  
  
# Create workspace  
# And bind it to the site folder at runtime  
VOLUME ["/www"]  
WORKDIR /www  
  
EXPOSE 80  
# init npm couchapp  
CMD ["/start.sh"]  

