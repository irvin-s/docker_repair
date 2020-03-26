#  
# Dockerfile for bryce-gibson/npm-lazy  
#  
FROM node:onbuild  
# Volumize the NPM package cache.  
VOLUME ["/root/.npm_lazy"]  
  
# Server is listening on 0.0.0.0:8080, by default.  
EXPOSE 8080  
# Default server arguments.  
CMD ["--show-config"]  
  
# Start the server on entry.  
ENTRYPOINT ["/usr/local/bin/node", "index.js"]  

