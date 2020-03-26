FROM ubuntu

USER root

RUN id

USER 1000

RUN id

RUN df -h

RUN ls -lha /dev/

RUN cat /etc/hosts

RUN echo 'A `docker ps` will list all the build containers currently executing. Use inspect to see what capabilities they have'

RUN sleep 11
