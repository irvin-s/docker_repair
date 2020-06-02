#this docker currently not used see /src/Dockerfile

FROM arm32v7/node:9

RUN apt-get update && \
    apt-get -y install curl && \
    apt-get -y install python build-essential
RUN npm install -g nodemon
RUN npm install -g serve

#first copy just the package and install dependencies
WORKDIR /usr/src/fullcyclereact/src/web/
COPY package*.json ./
RUN npm install
RUN npm install material-ui@next

#then copy source
COPY . .
RUN npm run build

EXPOSE 3000

#CMD npm run start
CMD serve -p 3000 build
