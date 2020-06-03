###############################################################################
# First stage: generate config files...
###############################################################################
FROM loicmahieu/alpine-envsubst AS generate_config
WORKDIR /tmp

ARG ADH6_URL="adh6.minet.net"
ARG SSO_LOGOUT="cas.minet.net/logout"
ARG SSO_AUTHORIZE="cas.minet.net/oauth2.0/authorize"

COPY frontend_angular/src/app/config/auth.config.template.ts .

RUN cat auth.config.template.ts | envsubst | tee auth.config.ts

###############################################################################
# 2nd stage, launch the app
###############################################################################
FROM node:8.16.0-stretch-slim

EXPOSE 8443

# Make TLS self-signed certificate and change its owner to the angular user.
RUN openssl genrsa -out /etc/ssl/private/adh6.key 2048 \
    && openssl req -new -key /etc/ssl/private/adh6.key -out /tmp/adh6.csr -subj "/C=FR/ST=Essonne/O=MiNET/CN=frontend" \
    && openssl x509 -req -days 365 -in /tmp/adh6.csr -signkey /etc/ssl/private/adh6.key -out /etc/ssl/certs/adh6.crt \
    && groupadd -r angular && useradd --no-log-init -r -m -g angular angular \
    && chmod 600 /etc/ssl/private/adh6.key \
    && chmod 600 /etc/ssl/certs/adh6.crt \
    && chown angular:angular /etc/ssl/private/adh6.key \
    && chown angular:angular /etc/ssl/certs/adh6.crt \
    && mkdir -p /adh6/frontend_angular \
    && chown angular:angular /adh6/frontend_angular

# Install angular system-wide
RUN npm install -g @angular/cli

WORKDIR /adh6/frontend_angular

# Install packages
COPY frontend_angular/package*.json ./

# Need angular user to install package
USER angular
RUN npm install
USER root

# Copy source code
COPY frontend_angular/*.json ./

# Copy the generated config files.
COPY --from=generate_config /tmp/auth.config.ts ./src/app/config/auth.config.ts

COPY frontend_angular/src ./src


USER angular
# We use /bin/sh to be able to use ENV vars...
CMD ["/bin/sh", "-c", "ng serve --host 0.0.0.0 --disable-host-check"]

