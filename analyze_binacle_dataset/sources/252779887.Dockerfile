# Use Alpine-node as a base image because it is much smaller.  
#  
# Base image size for mhart/alpine-node:4 is 13 MB  
# Base image for standard node:4 is 253 MB.  
#  
# Our production deploy does not have any C/C++ library dependencies yet  
# so this is still easy to do.  
FROM mhart/alpine-node:4  
# Snarf enough of the package config to do the library installs. This  
# avoids creation of extra layers as the library installs update at a  
# much slower rate from the rest of the package files.  
RUN mkdir /deploy  
WORKDIR /deploy  
COPY package.json package.json  
COPY npm-shrinkwrap.json npm-shrinkwrap.json  
  
# Install the library using a production configuration.  
ENV NODE_ENV production  
RUN npm install  
  
# Add the source code.  
ADD . .  
  
# Start the server.  
EXPOSE 3000  
CMD ["node", "src/server.js"]  

