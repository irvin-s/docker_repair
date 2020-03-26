FROM zzswang/docker-nginx-react
MAINTAINER zzswang@gmail.com

ENV BASE_URL= \
    API_REGEX=/api_vd? \
    API_GATEWAY=https://api.36node.com

COPY ./dist /app
