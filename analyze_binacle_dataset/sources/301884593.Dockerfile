from node:8

# dependencies
run mkdir /srv/app
copy ./app/package.json /srv/app/package.json
copy ./app/yarn.lock /srv/app/yarn.lock
workdir /srv/app
run yarn
