FROM mysql:5.5

COPY --from=healthcheck/mysql:latest /usr/local/bin/docker-healthcheck /usr/local/bin/

HEALTHCHECK CMD ["docker-healthcheck"]
