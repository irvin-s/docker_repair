FROM node:10.11.0-alpine

COPY . /app/
WORKDIR /app

RUN apk --no-cache add --virtual gyp-deps \
    build-base \
    python \
    && npm install \
    && apk del gyp-deps

ENV MESSENGER_API_URL="https://graph.facebook.com/v3.0" \
    NEXTBIKE_API_URL="https://api.nextbike.net/maps/nextbike-live.xml" \
    MAPS_STATIC_URL="https://maps.googleapis.com/maps/api/staticmap" \
    MAPS_PLACES_URL="https://maps.googleapis.com/maps/api/place" \
    BING_STATIC_URL="https://dev.virtualearth.net/REST/v1/Imagery/Map" \
    GIPHY_API_URL="http://api.giphy.com/v1/gifs" \
    NODE_ENV="production"

ENTRYPOINT ["node", "--experimental-modules"]
CMD ["src/index.mjs"]
