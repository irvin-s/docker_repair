FROM busybox  
  
WORKDIR /game  
  
COPY . .  
CMD ./game.sh  

