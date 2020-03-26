FROM bcoe/rr-follower:1.0.1

COPY files /etc/npme
COPY files/config-development.json /etc/npme/node_modules/@npm/registry-relational-models/config-development.json
COPY files/config-development.json /etc/npme/node_modules/@npm/relational-registry-follower/config-development.json
COPY files/bootstrap.js /etc/npme/node_modules/@npm/registry-relational-models/bootstrap.js
