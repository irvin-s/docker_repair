#this docker currently not used see /src/Dockerfile

FROM arm32v7/node:9

# Install Node.js and other dependencies
RUN apt-get update && \
    apt-get -y install curl && \
    apt-get -y install python build-essential
RUN npm install -g nodemon

#first copy package and install dependencies
WORKDIR /usr/src/fullcyclereact/src/api/
COPY package*.json ./
RUN npm install

#then copy source
COPY . .

EXPOSE 5000

CMD npm run prod
