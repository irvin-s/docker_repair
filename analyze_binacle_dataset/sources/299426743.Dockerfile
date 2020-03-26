FROM mhart/alpine-node:6.10.3

RUN apk add --no-cache make gcc g++ python git

RUN apk add dos2unix --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted

COPY . /srv/formio

RUN cd /srv/formio && npm install && npm rebuild && npm rebuild bcrypt --build-from-source

RUN chmod +x /srv/formio/docker/run.sh

RUN dos2unix /srv/formio/docker/run.sh

EXPOSE 80

ENTRYPOINT /srv/formio/docker/run.sh

CMD ['']
