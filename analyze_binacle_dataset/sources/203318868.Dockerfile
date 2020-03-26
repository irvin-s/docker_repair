FROM alpine
MAINTAINER qgp9 

# BASE SET
RUN apk update && apk upgrade && apk update
RUN apk add --update bash && rm -rf /var/cache/apk/*  

# ADDITIONAL SET
RUN apk add --update imagemagick git curl  && rm -rf /var/cache/apk/*

# NODEJS
RUN apk add --update nodejs && rm -rf /var/cache/apk/*  
#RUN apk add --update nodejs-dev alpine-sdk && rm -rf /var/cache/apk/*  

# NODEBB
#
RUN mkdir /data

ENV NODEBB_DIR /opt/nodebb/

WORKDIR ${NODEBB_DIR}

VOLUME  ${NODEBB_DIR}

EXPOSE  4567

ENV NODE_ENV=production \
    daemon=false \
    silent=false

CMD ["npm","start"]
