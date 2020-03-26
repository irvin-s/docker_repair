  
FROM advice/nodejs  
  
RUN npm install -g pm2@latest  
  
CMD ["pm2"]  
  

