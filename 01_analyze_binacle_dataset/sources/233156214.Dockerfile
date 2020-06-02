FROM mdillon/postgis:9.6
COPY db-healthcheck /usr/local/bin/
RUN chmod +x /usr/local/bin/db-healthcheck
HEALTHCHECK CMD ["db-healthcheck"]

