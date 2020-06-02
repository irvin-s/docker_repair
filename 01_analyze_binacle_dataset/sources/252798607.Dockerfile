# sudo docker build -t derekbekoe/marie-bot:dev .  
# sudo docker run -d -p 3978:3978 derekbekoe/marie-bot:dev  
# Set MICROSOFT_APP_ID, MICROSOFT_APP_PASSWORD, PORT  
FROM node:8.2  
COPY . /  
RUN npm install  
CMD node index.js  

