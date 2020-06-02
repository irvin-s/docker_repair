######################################################  
#  
# Agave JSON Mirror API  
# Tag: json-mirror  
#  
# https://bitbucket.org/taccaci/agave-json-mirror  
#  
# This is a simple API for querying and pretty-printing  
# JSON objects via a REST API.  
#  
# docker run -d -p 3000:3000 agaveapi/agave-cli bash  
#  
######################################################  
  
  
FROM node:0.10-onbuild  
MAINTAINER Rion Dooley <dooley@tacc.utexas.edu>  
  
EXPOSE 3000  
CMD ["node", "index.js"]

