FROM node:8  
RUN curl -o- -L https://yarnpkg.com/install.sh | bash  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY package.json yarn.lock /usr/src/app/  
RUN yarn  
  
# Bundle app source  
COPY . /usr/src/app  
  
# Run build script (webpack)  
RUN yarn run build  
  
EXPOSE 8090  
CMD [ "yarn", "start" ]

