FROM zeroboh/nginx:1.11-alpine

ARG PROJECT_TYPE

COPY ./${PROJECT_TYPE}.conf.template /default.conf.template
COPY ./docker-entrypoint /docker-entrypoint
COPY ./docker-entrypoints /docker-entrypoints

RUN chmod +x /docker-entrypoint && chmod +x -R /docker-entrypoints

ENTRYPOINT ["/docker-entrypoint"]