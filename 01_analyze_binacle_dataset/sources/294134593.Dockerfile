FROM scratch

ENV WEB_SERVER_PORT :8081

EXPOSE $WEB_SERVER_PORT

COPY hello /
COPY templates templates

CMD ["/hello"]