FROM hypriot/rpi-alpine-scratch:edge

# Add support for cross-builds
COPY qemu-arm-static /usr/bin/

RUN apk add --update nginx

COPY nginx.conf /etc/nginx/
COPY index.html data.json /usr/share/nginx/html/
