#
# Hosts the static content
#
FROM nginx:1.11.5-alpine

EXPOSE 80
RUN apk add --update curl &&  \
    rm -rf /var/cache/apk/* && \
    rm /etc/nginx/conf.d/default.conf

#
# Add the latest commit ref and fetch the latest tar file
# Extract, move, cleanup & create a build version.txt file
#
COPY .git/refs/heads/master /commit_hash.txt
RUN mkdir -p /var/www \
    && cd /var/www \
    && ( \
      commit_hash=$( cat /commit_hash.txt | cut -c -8); \
      curl -O https://s3.amazonaws.com/docker-tmp-release/app_$commit_hash.tar.gz; \
      tar -xvzf /var/www/app_$commit_hash.tar.gz; \
      mv dist webapp; \
      rm app_$commit_hash.tar.gz; \
      date > webapp/version.txt; \
      echo $commit_hash >> webapp/version.txt; \
    )

COPY deployment/nginx.conf /etc/nginx/nginx.conf
COPY deployment/webapp.conf /etc/nginx/sites-enabled/webapp.conf
