FROM node  
RUN mkdir /stackline  
ADD . /stackline  
WORKDIR /stackline  
RUN npm i  
EXPOSE 80  
CMD ["npm", "start"]

