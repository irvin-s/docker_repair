FROM node:argon  
  
#Environment Variables  
ENV DATABASE_URI mongodb://localhost/ideagarden  
ENV HASH_SECRET shhhhh  
ENV DEFAULT_EMAIL info@ideagarden.local  
ENV PORT 80  
# Create app directory  
RUN mkdir -p /ideaGarden  
WORKDIR /ideaGarden  
  
# Install  
COPY package.json /ideaGarden  
COPY gulpfile.js /ideaGarden  
COPY ./src /ideaGarden/src  
  
# Bundle app source  
RUN npm install  
RUN ./node_modules/.bin/gulp build  
RUN ./node_modules/.bin/gulp install_npm  
COPY config_docker.js /ideaGarden/build/config.js  
  
VOLUME /ideaGarden/build/imageData  
  
#Image configuration  
ADD start.sh /start.sh  
RUN chmod 755 /*.sh  
  
EXPOSE 80  
CMD ["/start.sh"]  

