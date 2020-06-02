FROM ghost
COPY ./config.production.json /var/lib/ghost/content/config.production.json
EXPOSE 2368
#CMD ["npm","start","--production"]

