FROM aahoo/yeoman  
MAINTAINER aahoo <github.com/aahoo>  
RUN npm install -g generator-polymer  
RUN npm cache clear  
EXPOSE 5000  
CMD ["/bin/bash"]  

