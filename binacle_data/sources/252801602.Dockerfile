FROM node  
RUN npm install --global newman  
CMD ["newman", "--help"]  

