FROM node  
MAINTAINER Attila Szeremi <attila+webdev@szeremi.com>  
RUN mkdir /src  
WORKDIR /src  
RUN cd /src  
# Copy just the package.json file file as a cache step.  
COPY package.json /src/package.json  
  
# Attempt to fix ugly output http://stackoverflow.com/a/39444754/1381550  
ENV NPM_CONFIG_PROGRESS false  
ENV NPM_CONFIG_SPIN false  
  
# Disable progress so npm would install faster.  
# Disable colors, because Dockerhub can't display them.  
# Install NPM packages excluding the dev dependencies.  
RUN npm set progress=false && \  
npm set color=false && \  
npm --color false \--no-color -q install  
  
COPY . .  
RUN npm --no-color -q run build  
# Needed for nginx-proxy  
EXPOSE 8080  
CMD ["npm", "run", "start"]  

