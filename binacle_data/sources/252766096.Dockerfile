FROM aahoo/yeoman  
MAINTAINER aahoo <github.com/aahoo>  
RUN npm install -g generator-webapp  
RUN npm cache clear  
EXPOSE 9000  
CMD ["/bin/bash"]  

