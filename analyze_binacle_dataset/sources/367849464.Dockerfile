FROM node

RUN npm install --global \
    riot \
    webpack \
    browser-sync

ADD ./watch.sh /watch.sh

WORKDIR /app

CMD ["/watch.sh"]
