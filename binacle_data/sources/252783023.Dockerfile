FROM lambci/lambda:build  
ENV NODE_ENV=production  
  
COPY installDeps.sh /usr/bin/installDeps.sh  
  
WORKDIR /dawson-dist  
CMD bash /usr/bin/installDeps.sh  
  

