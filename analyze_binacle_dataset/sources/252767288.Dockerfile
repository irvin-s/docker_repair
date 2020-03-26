FROM node:0.11.15  
RUN mkdir -p /usr/src/app  
  
COPY redirect.js /usr/src/app/  
  
EXPOSE 80  
CMD ["node", "/usr/src/app/redirect.js"]  

