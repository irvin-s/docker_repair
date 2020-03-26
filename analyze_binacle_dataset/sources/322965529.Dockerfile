
#see: https://github.com/hashicorp/docker-consul/blob/5652c54974b94465f93382b65c10efabde7928c8/0.X/Dockerfile
FROM consul:1.4.4

RUN apk add --update bash \
    && rm -rf /tmp/* /var/cache/apk/*

COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
