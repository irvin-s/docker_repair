# Building:  
# docker build -t cows .  
# Running:  
# docker run cows <cow_number>  
FROM mhart/alpine-node:4  
RUN mkdir -p /code/  
WORKDIR /code/  
RUN npm init -y  
RUN npm install cows  
ADD show_cow.js ./  
  
ENTRYPOINT ["node", "show_cow.js"]  

