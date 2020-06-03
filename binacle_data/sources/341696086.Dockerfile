FROM bertoost/nginx:1.15.9

LABEL maintainer="Bert Oost <hello@bertoost.com>"

# Remove any parent placeholder files from NginX config
RUN find /etc/nginx/conf.d/ -name "*.placeholder" -type f -delete

COPY conf.d/craftcms.conf /etc/nginx/conf.d/default.conf