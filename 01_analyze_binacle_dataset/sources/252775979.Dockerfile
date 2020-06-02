FROM node  
  
RUN apt-get update  
RUN apt-get install -y vim emacs screen tmux nano curl wget  
RUN npm install hipster n slap -g  
RUN n 0.11.13  
RUN n 0.10.31  
  
RUN mkdir /expose  
WORKDIR /expose  
RUN npm install bmpvieira/expose-bash-over-websockets http-proxy  
ADD proxy.js /expose/proxy.js  
  
WORKDIR /root  
  
CMD n use 0.10.31 /expose/proxy.js  
  
ADD initfile /root/.initfile  
ONBUILD ADD initfile /root/.initfile  

