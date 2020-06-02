FROM node:6.9.5-alpine  
  
ENV PORT 3000  
ARG NODE_ENV=production  
  
# Install Yarn  
RUN apk add --no-cache --virtual .build-deps tar curl bash gnupg \  
&& curl -o- -L https://yarnpkg.com/install.sh | bash \  
&& apk del .build-deps  
ENV PATH /root/.yarn/bin:$PATH  
  
# Create app directory  
RUN mkdir -p /usr/src/skipass.site  
WORKDIR /usr/src/skipass.site  
  
# Install app dependencies  
ADD package.json yarn.lock /usr/src/skipass.site/  
RUN yarn global add pm2 \  
&& yarn install --pure-lockfile \  
&& yarn cache clean  
  
COPY . /usr/src/skipass.site/  
  
RUN npm run build \  
# Remove source files (they unneeded)  
&& rm -rf /src  
  
VOLUME /usr/src/skipass.site/public  
  
EXPOSE ${PORT}  
  
CMD ["pm2-docker", "--format", "ecosystem.config.js"]  

