FROM node:6.11.1
COPY dist /usr/bitbloq-backend
ENV MONGO_URL files_mongo_1
WORKDIR /usr/bitbloq-backend
CMD /bin/bash -c "npm start"
