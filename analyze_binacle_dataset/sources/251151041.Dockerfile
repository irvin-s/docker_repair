FROM node:6

COPY index.js /app/index.js

WORKDIR /app
RUN npm install stripe-local

CMD node index.js
