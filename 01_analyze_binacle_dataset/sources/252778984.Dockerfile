FROM node:0.12.5  
# Add source  
ADD gulpfile.coffee package.json bower.json /src/  
COPY client/partials /src/client/partials  
COPY client/resources /src/client/resources  
COPY client/src /src/client/src  
COPY client/styles /src/client/styles  
COPY client/vendor /src/client/vendor  
COPY server/src /src/server/src  
COPY server/views /src/server/views  
  
ENV PORT 8080  
EXPOSE $PORT  
  
# Build  
WORKDIR /src/  
RUN npm install --unsafe-perm  
RUN ./node_modules/.bin/bower --allow-root install  
RUN ./node_modules/.bin/gulp  
RUN rm -rf node_modules  
RUN npm install --production --unsafe-perm  
  
CMD ["npm", "run", "production"]  

