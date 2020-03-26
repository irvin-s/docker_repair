# Dockerfile for fpco/soh-site-base
#-*- mode: conf; -*-

# ubuntu:14.04
FROM ubuntu@sha256:d67ef8e385f1c8b13d8c3e7622dc31b51d07e5623c1d034ebe2acb14a11fb30d

RUN apt-get update \
 && apt-get install -y --no-install-recommends libgmp10 libpq5 openssh-client ca-certificates \
 && apt-get clean

# Symlink client_session_key.aes because soh-site seems to insist on
# looking for the file in the root.
RUN ln -s config/client_session_key.aes client_session_key.aes

COPY _artifacts/config/ /config/
COPY _artifacts/soh-site /usr/local/bin/soh-site
COPY _artifacts/static/ /static/
