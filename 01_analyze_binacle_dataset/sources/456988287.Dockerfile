FROM tutum/nginx:latest@sha256:69a727916ab40de88f66407fb0115e35b759d7c6088852d901208479bec47429
RUN rm /etc/nginx/sites-enabled/default
COPY sites-enabled/ /etc/nginx/sites-enabled
