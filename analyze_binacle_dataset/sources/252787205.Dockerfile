FROM python:alpine3.6  
WORKDIR /root  
  
ADD lib lib  
ADD maps maps  
ADD evo_life .  
  
ENTRYPOINT ./evo_life  

