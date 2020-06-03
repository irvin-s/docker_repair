FROM node:latest
WORKDIR /app
ENV PORT=3000
COPY . .
RUN npm install
EXPOSE $PORT

COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

