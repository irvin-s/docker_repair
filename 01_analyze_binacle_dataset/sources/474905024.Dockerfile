FROM node:4.4.2
RUN apt-get update && apt-get install -y git
COPY dist /usr/bitbloq-backend
ENV MONGO_URL files_mongo_1
WORKDIR /usr/bitbloq-backend
RUN npm cache clean && npm install
CMD /bin/bash -c "sed -i 's@MONGO_URL@'"$MONGO_URL"'@g' /usr/bitbloq-backend/app/res/config.js && node index.js"
