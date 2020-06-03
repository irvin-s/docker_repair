FROM npmwharf/kickerd:latest
MAINTAINER Alex Robson <asrobson@gmail.com>

WORKDIR /app
COPY . .
RUN npm i
RUN npm uninstall node-gyp -g && apk del python make g++ && rm -rf /var/cache/apk/*