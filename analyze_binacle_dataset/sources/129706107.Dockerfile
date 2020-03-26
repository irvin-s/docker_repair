FROM node:latest
WORKDIR /app
ENV PORT=3000
COPY . .
RUN npm install
EXPOSE $PORT
ENTRYPOINT ["npm", "start"]