FROM node:boron

RUN npm install -g yarn

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN mkdir -p /source
WORKDIR /source

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
