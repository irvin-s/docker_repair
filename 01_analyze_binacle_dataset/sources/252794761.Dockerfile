FROM node:8  
# Env variables  
ENV PORT 80  
ENV PUBLISHABLE_KEY "stripe_publish_key"  
ENV SECRET_KEY "stripe_secret_key"  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY package.json /usr/src/app/  
RUN npm install --loglevel warn  
  
# Bundle app source  
COPY . /usr/src/app  
  
# Build JS  
RUN npm run build  
  
EXPOSE 80  
CMD npm start

