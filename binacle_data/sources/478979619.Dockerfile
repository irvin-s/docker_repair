# Node runtime version
FROM node:8

# The api directory insede of the docker image
WORKDIR /app

# A wildcard is used to ensure both package.json AND package-lock.json are copied to the docker image
COPY package*.json ./

# Copy the project to the docker image
COPY . .

# Install the API dependencies with NPM
RUN npm install

# Informe to the docker, the door let's use
EXPOSE 8080

CMD ["npm", "start"]
