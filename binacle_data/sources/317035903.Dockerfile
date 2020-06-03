FROM node:10.0.0 as ambiente-de-build

COPY . /app

WORKDIR /app

RUN npm install

FROM node:10.0.0-alpine as ambiente-de-execucao

COPY --from=ambiente-de-build /app /app

WORKDIR /app

ENV PORT=10000

CMD [ "node", "index.js" ]

EXPOSE 10000
