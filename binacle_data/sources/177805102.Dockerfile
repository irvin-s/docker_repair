FROM node:0.12

# This is needed for node-canvas dependency on cairo. Annoyingly large...
RUN apt-get update && apt-get install -yy --no-install-recommends \
     libcairo2-dev libjpeg62-turbo-dev libpango1.0-dev libgif-dev \
     build-essential g++

#Create non-root user
RUN groupadd -r dnmonster && useradd -r -g dnmonster dnmonster

#Following is effectively onbuild image. We can't use the official onbuild image
#as it would run the above line everytime which is very tiresome
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install
COPY ./src /usr/src/app

RUN chown -R dnmonster:dnmonster /usr/src/app
USER dnmonster

EXPOSE 8080

CMD [ "npm", "start" ]
