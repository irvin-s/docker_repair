  
FROM node:6  
ENV PORT 3001  
RUN pwd; ls -lart  
COPY envapp.js ./  
COPY package.json ./  
RUN npm install  
EXPOSE 3001  
CMD ["node", "./envapp.js"]  

