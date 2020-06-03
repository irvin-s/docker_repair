FROM hypriot/rpi-node  
  
RUN npm install  
RUN npm install nodemon -g  
  
EXPOSE 7070  
CMD [ "nodemon", "server.js"]  
  

