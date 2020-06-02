# Build react app
FROM node:6 as builder
RUN mkdir /whales
WORKDIR /whales
COPY whaleDemo .

RUN npm install --quiet

CMD ["npm", "start"]

EXPOSE 3000

