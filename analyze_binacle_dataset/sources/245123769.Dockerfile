FROM wyntuition/angular2-slim

EXPOSE 4200/tcp

#ENV USE_POLLING_FILE_WATCHER=true
RUN apk update && \
    apk upgrade && \
    apk add vim

COPY . /app/
WORKDIR /app

# node_modules has to exist locally, as it gets copied into the container, then the host mapped over it so npm install currenty has to be run locally first
RUN npm install

CMD ["npm", "start"]