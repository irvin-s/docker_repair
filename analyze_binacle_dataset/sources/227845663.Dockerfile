FROM meroje/alpine-nchan:latest@sha256:afc4866b0874369e2652cccd3aff6cba2ca980e97f872a134cc882107b44c7d5

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.vh.default.conf /etc/nginx/conf.d/default.conf
COPY html/ /usr/share/nginx/html
