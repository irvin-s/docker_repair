FROM node:dubnium-alpine

# I need it for my eslint rules package that I'm using from git
RUN apk update && apk add --no-cache git

WORKDIR '/app'
COPY ./package*.json ./
RUN npm install
COPY . .
CMD ["npm", "run", "start"]
