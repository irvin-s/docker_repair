FROM node:alpine
WORKDIR /app
ADD . /app
RUN npm install
EXPOSE 3000
ENV NAME World
CMD ["npm", "start"]
