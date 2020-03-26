FROM node:6.11

COPY . /app

RUN curl https://install.meteor.com/?release=1.4.1.1 | /bin/sh
RUN mkdir build && \
cd /app && \
meteor build /build && \ 
cd /build && \
tar -xzf app.tar.gz && \
rm -rf app.tar.gz && \
cd /build/bundle/programs/server && \
npm install && \
rm -rf ~/.meteor

EXPOSE 3000

ENTRYPOINT node /build/bundle/main.js

