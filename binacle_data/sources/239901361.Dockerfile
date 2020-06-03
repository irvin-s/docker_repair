FROM pagarme/docker-nodejs:8.9

COPY package.json /superbowleto/package.json
WORKDIR /superbowleto

RUN npm install

EXPOSE 3000
