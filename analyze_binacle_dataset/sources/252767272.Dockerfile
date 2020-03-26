FROM mhart/alpine-node:4  
ADD app.js ./  
  
EXPOSE 3000  
CMD ["node", "app.js"]  

