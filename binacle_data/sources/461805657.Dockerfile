FROM node:9 as builder

LABEL description="Landingpage for 'what the street'"
LABEL project="lab-whatthestreet"
LABEL maintainer="florian.porada@moovel.com"

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM node:9

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/.next /usr/src/app/.next
COPY --from=builder /usr/src/app/node_modules /usr/src/app/node_modules
COPY --from=builder /usr/src/app/server /usr/src/app/server
COPY --from=builder /usr/src/app/static /usr/src/app/static
COPY --from=builder /usr/src/app/config.json /usr/src/app/
COPY --from=builder /usr/src/app/next.config.js /usr/src/app/
COPY --from=builder /usr/src/app/gifgallery.json /usr/src/app/
COPY --from=builder /usr/src/app/package.json /usr/src/app/

# We need to env var only at runtime with whatthestreet
ARG mapbox_token
ENV env_mapbox_token=$mapbox_token
ARG ga_id
ENV env_ga_id=$ga_id
#example: /project/whatthestreet
ARG URL_PREFIX="" 
ENV URL_PREFIX $URL_PREFIX
#example: whatthestreet.moovellab.com
ARG ROOT_URL=""
ENV ROOT_URL $ROOT_URL
#example: https://s3-eu-west-1.amazonaws.com/gif.whatthestreet.moovellab.com
ARG S3_GIF_BUCKET="https://s3-eu-west-1.amazonaws.com/gif.whatthestreet.moovellab.com"
ENV ROOT_URL $S3_GIF_BUCKET

EXPOSE 80

CMD ["npm", "start"]