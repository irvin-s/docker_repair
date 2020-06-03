FROM node:0.10.41  
RUN mkdir code  
RUN mkdir build  
COPY . code  
WORKDIR code  
RUN curl https://install.meteor.com/ | sh  
RUN meteor npm install  
RUN meteor build --directory ../build --server-only  
RUN cd ../build/bundle/programs/server  
RUN npm install  
  
CMD ["node","../build/bundle/main.js"]

