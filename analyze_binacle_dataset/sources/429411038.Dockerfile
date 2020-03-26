FROM ubuntu:xenial

RUN apt update \
    && apt upgrade -y

RUN apt install gcc build-essential git gzip arduino gawk curl -y

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -; apt install nodejs -y

WORKDIR /opt/server

COPY src /opt/server

RUN npm install

RUN mkdir -p /opt/builder

EXPOSE 8888

CMD ["node", "app.js"]