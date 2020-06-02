FROM chetbox/slimerjs:1.2.1  
MAINTAINER chetbox  
  
ADD ./ghoulio.js /app/ghoulio.js  
  
ENTRYPOINT ["/usr/bin/slimerjs", "/app/ghoulio.js"]  
CMD []  

