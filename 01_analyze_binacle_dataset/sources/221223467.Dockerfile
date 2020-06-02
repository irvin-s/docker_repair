ARG image_tag=latest
FROM elifesciences/journal:${image_tag} AS app
FROM nginx:1.13.12-alpine

COPY .docker/nginx-default.conf /etc/nginx/conf.d/default.conf
COPY --from=app /srv/journal/web/ /srv/journal/web/
