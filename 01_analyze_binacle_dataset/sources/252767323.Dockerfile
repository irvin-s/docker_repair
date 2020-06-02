# generic node based application  
# alexindigo/node-app  
FROM alexindigo/node-dev:0.12.0  
MAINTAINER Alex Indigo <iam@alexindigo.com>  
  
# Install pm2 process manager  
RUN npm install -g pm2  
  
# Create workspace  
# And bind it to the site folder at runtime  
VOLUME ["/www"]  
WORKDIR /www  
  
# expect webapp by default  
EXPOSE 80  
EXPOSE 443  
# autostart application  
CMD ["./autostart"]  

