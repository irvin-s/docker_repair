FROM node:8  
# Creation of the Fractal project directories  
RUN mkdir -p /opt/project \  
&& mkdir -p /opt/project/components \  
&& mkdir -p /opt/project/docs \  
&& mkdir -p /opt/project/build \  
&& mkdir -p /opt/project/assets  
  
# Installation of Gulp.  
RUN npm install --global gulp-cli  
  
# the package.json file  
COPY config/package.json /opt/project/package.json  
  
# The project directory  
WORKDIR /opt/project/  
  
# Installation of Fractal and Gulp as dependency  
# RUN npm install && npm cache clean --force \  
# && npm install --save @frctl/fractal \  
RUN npm install --save @frctl/fractal \  
&& npm i -g @frctl/fractal \  
&& npm install --save @frctl/twig \  
&& npm install --save-dev gulp \  
&& npm install --save-dev gulp-cli \  
&& npm install --save-dev gulp-sass  
  
# ENV PATH /opt/project/fractal/node_modules/.bin:$PATH  
# the fractal.js file  
COPY config/fractal.js /opt/project/fractal.js  
  
# the gulpfile.js file  
COPY config/gulpfile.js /opt/project/gulpfile.js  
  
# the component example files  
COPY config/example /opt/project/components/example  
  
RUN chown -R node:node /opt/project  
  
# Expose 3000 for the node.js server, 3002 for the BrowserSync  
EXPOSE 3000 3002  
# The project volume  
VOLUME /opt/project  

