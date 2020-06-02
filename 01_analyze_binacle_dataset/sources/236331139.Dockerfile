FROM node:lts-alpine AS build

WORKDIR /srv

COPY package.json ./

#Bug: https://npm.community/t/dev-only-only-dev-install-fails-when-module-is-a-dependency-of-multiple-places/2613
#RUN npm install --only=dev
RUN npm install -D

COPY . .

RUN npm run build


FROM node:lts-alpine
LABEL author="Colin Cheng <zbinlin@outlook.com>"

WORKDIR /srv

COPY --from=build /srv/dist/ /srv/

RUN npm install --production

EXPOSE 8080

ENV NODE_ENV=production \
    NODE_ASSETS_PATH=public \
	 HOST=localhost \
	 PORT=8080

CMD [ "node", "/srv/index.js" ]
