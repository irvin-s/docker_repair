FROM ubuntu:16.04  
RUN apt-get update  
RUN apt-get install curl -y  
  
Add . /home/ubuntu/app  
  
RUN curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh  
RUN bash nodesource_setup.sh  
  
RUN apt-get install nodejs -y  
  
RUN npm install pm2 -g  
  
WORKDIR home/ubuntu/app  
CMD ["node", "app.js"]  
# CMD ["chmod", "+x", "/home/ubuntu/app/start.sh"]  
# CMD ["./home/ubuntu/app/start.sh"]  
EXPOSE 3000  
# CMD ["curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -"]  

