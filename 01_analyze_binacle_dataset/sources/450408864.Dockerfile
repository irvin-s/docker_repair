# creates a layer from the node:8.14-alpine Docker image
FROM node:8.14-alpine

# create the app directory for inside the Docker image
WORKDIR /usr/src/app

# copy and install app dependencies from the package.json (and the package-lock.json) into the root of the directory created above
COPY package*.json ./
RUN yarn install

# bundle app source inside Docker image
COPY . .

# expose port 8080 to have it mapped by Docker daemon
EXPOSE 3000

# define the command to run the app
CMD [ "yarn", "start" ]
