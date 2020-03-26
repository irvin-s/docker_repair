FROM node:9.11-alpine

# Prepare app directory
WORKDIR /src

ADD . .

RUN npm install

# Expose the app port
EXPOSE 5000

# Start the app
CMD [ "npm", "run", "production" ]