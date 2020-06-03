FROM mhart/alpine-node:4.4

# APK is the alpine-pakage-manager Python gcc is need for node-sass
RUN apk add --no-cache make gcc g++ python

#Install deps
RUN mkdir /app
COPY app/package.json /app/package.json
RUN cd /app && npm install

#Add all source code
ADD app /app/
RUN cd /app && npm run build

#Default command
CMD ["/app/runserver.sh"]
