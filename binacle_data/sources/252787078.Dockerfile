# Pull base image.  
FROM dockerfile/nodejs  
  
# Bundle app source  
ADD . /src  
  
EXPOSE 1337  
CMD ["node", "/src/index.js"]  

