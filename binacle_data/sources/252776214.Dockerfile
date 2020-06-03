FROM node:8  
COPY ./ /app  
  
WORKDIR /app  
  
RUN mkdir /app/data  
  
ENV DATABASE_URL sqlite:////app/data/data.db  
ENV MAILER_URL smtp://smtp:1025  
RUN npm install --unsafe-perm;  
  
RUN npm run build;  
  
CMD ["npm", "start"]  

