FROM hacsoc/jolly-advisor

MAINTAINER Matthew Bentley <matthew.t.bentley@gmail.com>

RUN apt-get update && apt-get install -y \
    cron \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

COPY crontab /var/spool/cron/crontabs/root
RUN chmod 600 /var/spool/cron/crontabs/root

CMD ["cron", "-f"]
