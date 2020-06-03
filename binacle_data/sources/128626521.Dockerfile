FROM node:8

WORKDIR /src
ADD . /src

RUN ls
RUN cd front && npm install && npm run build

FROM node:8-alpine

# System dependencies
RUN apk add --no-cache tzdata nmap

# Create src folder
RUN mkdir /src

WORKDIR /src
ADD . /src
COPY --from=0 /src/front/build /src/server/static
WORKDIR /src/server

RUN apk add --no-cache --virtual .build-deps make gcc g++ python git \
    && npm install --production \
    && npm install -g modclean \
    && modclean -n default:safe,default:caution -r \
    && npm remove -g modclean \
    && npm cache clean --force \
    && apk del .build-deps

ENV NODE_ENV production

# Export listening port
EXPOSE 1443

CMD ["npm" ,"run", "start:prod"]