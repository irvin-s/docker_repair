FROM keymetrics/pm2:latest  
  
# Set a working directory  
WORKDIR /usr/src/app  
COPY ./build/package.json .  
COPY ./build/yarn.lock .  
COPY ./pm2.prod.json .  
COPY ./src ./src  
COPY ./tools ./tools  
COPY ./public ./public  
RUN ls -al -R  
# Install Node.js dependencies  
ENV NPM_CONFIG_LOGLEVEL warn  
RUN yarn add global pm2  
# RUN npm uninstall pm2-auto-pull  
# RUN yarn add pm2-auto-pull  
RUN yarn install --production --no-progress  
# RUN pm2 set pm2-auto-pull:interval 60000  
EXPOSE 3000  
# Copy application files  
RUN npm run build  
COPY ./build .  
  
CMD ["pm2-docker", "pm2.prod.json"];  

