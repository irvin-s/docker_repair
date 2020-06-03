FROM node:9  
ENV INFURA_ACCESS_TOKEN McTgYQlwTTrQ6s21EE5e  
ENV TRANSACTION_SPEED medium  
ENV TRANSACTION_GAS_LIMIT 21000  
ENV MODE mainnet  
  
RUN mkdir -p /app  
WORKDIR /app  
  
COPY . /app  
  
RUN npm install  
  
RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime  
  
CMD [ "node", "./process.js" ]

