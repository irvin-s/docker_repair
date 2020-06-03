FROM zimbra/zm-base-os:devcore-ubuntu-16.04

USER root
COPY ./entrypoint.sh /home/build/entrypoint.sh
RUN chmod +x /home/build/entrypoint.sh

ENTRYPOINT /home/build/entrypoint.sh