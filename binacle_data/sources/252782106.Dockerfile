FROM node:7.10.0-alpine  
  
COPY RiverSongService.js .  
  
EXPOSE 8888  
CMD ["node", "RiverSongService.js"]

