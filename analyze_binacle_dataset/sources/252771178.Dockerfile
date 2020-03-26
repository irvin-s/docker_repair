FROM node:boron  
  
RUN curl -o- -L https://yarnpkg.com/install.sh | bash  
ENV PATH "$HOME/.yarn/bin:$PATH"  
WORKDIR /usr/src/app  
  
COPY . .  
  
ARG NODE_ENV  
ENV NODE_ENV $NODE_ENV  
  
RUN yarn  
RUN npm run-script prepublish  
  
EXPOSE 5000  
CMD ["npm", "start"]  

