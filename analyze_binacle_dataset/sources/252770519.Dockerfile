FROM node:8.4.0  
# includes node v8.4.0, yarn v0.27.5  
RUN apt-get update && apt-get install -y jq  
RUN npm install -g @sentry/cli --unsafe-perm  
  
CMD ["node"]  
  

