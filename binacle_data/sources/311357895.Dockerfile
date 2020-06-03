# This image will be published as dspace/dspace-angular-bare
# This image assumes that the angular source code has been mounted as /app
# See https://dspace-labs.github.io/DSpace-Docker-Images/ for usage details

FROM node:8
WORKDIR /app
ADD start.sh /tmp
EXPOSE 3000

CMD /tmp/start.sh
