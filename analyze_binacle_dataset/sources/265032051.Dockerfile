FROM parity/parity:v2.5.0
LABEL maintainer="vincent@serpoul.com"

# SAD but It seems impossible to read the mount otherwise
# https://github.com/moby/moby/issues/7198
USER root

VOLUME ["/home/parity/.local/share/io.parity.ethereum"]

COPY ./entrypoint.sh /home/parity/entrypoint.sh

ENTRYPOINT ["/home/parity/entrypoint.sh"]