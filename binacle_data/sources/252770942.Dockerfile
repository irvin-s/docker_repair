FROM google/nodejs  
  
MAINTAINER Adrian Gonzalez Barbosa "adrian.gonzalez.barbosa@gmail.com"  
RUN mkdir /app  
WORKDIR "/app"  
  
RUN git clone https://github.com/agonbar/nodejs-chat.git /app  
RUN npm install  
CMD ["node","/app/server.js"]  
  
EXPOSE 8082  

