FROM bcoe/rr-service:1.0.0

COPY files/config-development.json /etc/npme/node_modules/@npm/registry-relational-service/config-development.json
