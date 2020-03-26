# build from the official ghost dockerfile  
FROM ghost  
  
COPY themes $GHOST_SOURCE/content/themes/

