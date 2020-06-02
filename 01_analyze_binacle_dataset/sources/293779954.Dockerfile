FROM registry:2.5.1

COPY custom-entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
