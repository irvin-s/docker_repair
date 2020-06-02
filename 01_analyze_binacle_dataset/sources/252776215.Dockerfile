FROM node:8  
COPY ./ /app  
  
WORKDIR /app  
  
RUN npm install --unsafe-perm;  
  
RUN npm run build;  
  
# Default Environment  
ENV MESSENGER_ADAPTER_DSN amqp://guest:guest@messenger:5672  
ENV MAILER_URL smtp://smtp:1025  
ENV SITE_EMAIL Example <mail@example.com>  
ENV BRIDE_EMAIL Awesome <awesome@example.com>  
ENV GROOM_EMAIL Sauce <sauce@example.com>  
  
CMD ["npm", "start"]  

