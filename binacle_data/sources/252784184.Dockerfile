FROM node:6.9  
# prepare a user which runs everything locally! - required in child images!  
RUN useradd --user-group --create-home --shell /bin/false app  
  
ENV HOME=/home/app  
WORKDIR $HOME  
  
RUN npm install -g @angular/cli yarn && npm cache clean  
  
EXPOSE 4200  

