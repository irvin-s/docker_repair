FROM node:8

RUN apt-get update \
	&& apt-get install --yes libusb-1.0-0-dev

COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
WORKDIR /app
RUN npm install

COPY tsconfig.json /app/tsconfig.json
COPY source/ /app/source/
COPY tests/ /app/tests/
COPY typings/ /app/typings/
COPY LICENSE /app/LICENSE
COPY README.md /app/README.md

RUN npm run build

ENTRYPOINT [ "npm", "test" ]
