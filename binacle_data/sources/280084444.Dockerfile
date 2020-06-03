FROM node:6-alpine

ENV VERSION "v2.2.6"
ENV FOLDER "swagger-ui-2.2.6"

WORKDIR /app

RUN apk add --no-cache openssl \
	&& wget -qO- https://github.com/swagger-api/swagger-ui/archive/$VERSION.tar.gz | tar xvz \
	&& cp -r $FOLDER/dist/* . \
	&& rm -rf $FOLDER \
	&& apk del openssl

RUN npm install -g http-server

RUN sed -i.bak 's/url: url,/url: url, enableCookies: true,/' index.html \
	&& sed -i.bak 's/http:\/\/petstore\.swagger\.io\/v2\/swagger\.json/http:\/\/localhost:9876\/modmod\.yaml/' index.html

COPY ./swagger-ui.js /app/swagger-ui.js
COPY ./yaml/* /app/

CMD ["http-server", "-p", "9876"]
