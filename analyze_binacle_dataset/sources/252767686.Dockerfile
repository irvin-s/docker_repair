FROM node:8-alpine  
  
WORKDIR /app  
COPY . .  
RUN npm install --production  
  
ENTRYPOINT [ "node", "/app/lib/cli.js", "$@" ]

